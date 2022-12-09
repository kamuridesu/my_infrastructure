. /vagrant/configs/shell/provision_common.sh

start_kube() {
    if [[ "$PROVISIONED" == "FALSE" ]]; then
        cowsay Starting kubeadm
        kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-cert-extra-sans=10.0.1.100 --control-plane-endpoint master:6443 --apiserver-advertise-address=10.0.1.100
        export KUBECONFIG=/etc/kubernetes/admin.conf
        cp /etc/kubernetes/admin.conf ~
        mkdir -p /home/vagrant/.kube/
        touch /home/vagrant/.kube/config
        cat /etc/kubernetes/admin.conf > /home/vagrant/.kube/config
        MASTER_NAME=$(kubectl get nodes | head -2 | tail -1 | awk '{print $1}')
        kubectl taint node $MASTER_NAME node-role.kubernetes.io/control-plane:NoSchedule-
        cowsay Kube started!
    fi
    export KUBECONFIG=/etc/kubernetes/admin.conf
}

setup_kubernetes() {
    start_kube
}

install_helm() {
    # https://helm.sh/docs/intro/install/#from-script
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    cowsay Installing Helm
    chmod 700 get_helm.sh
    ./get_helm.sh
}


setup_calico() {
    cowsay Installing calico... # https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/tigera-operator.yaml
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/custom-resources.yaml
    # kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.5/manifests/calico.yaml
    while [[ "$(kubectl get pods -n calico-apiserver | tail -1 | awk '{print $3}')" != "Running" ]]; do
        cowsay Waiting Calico resources...
        sleep 5
    done
    cowsay Calico is running!
}

setup_istio() {
    cowsay Setting up Istio
    # Start from here: https://istio.io/latest/docs/setup/install/helm/
    helm repo add istio https://istio-release.storage.googleapis.com/charts
    helm repo update
    kubectl create namespace istio-system
    helm install istio-base istio/base -n istio-system
    helm install istiod istio/istiod -n istio-system --wait
    # On step four, from here: https://istio.io/latest/docs/setup/additional-setup/gateway/
    cowsay Creating Istio ingress gateway
    kubectl create namespace istio-ingress
    kubectl label namespace istio-ingress istio-injection=enabled # https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/#automatic-sidecar-injection
    helm install istio-ingressgateway istio/gateway -n istio-ingress
    while [[ "$(kubectl get pods -n istio-ingress | tail -1 | awk '{print $3}')" != "Running" ]]; do
        cowsay Waiting Istio...
        sleep 5
    done
    cowsay Istio started!
}

setup_argocd() {
    cowsay Setting up argocd
    # https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
    kubectl create namespace argocd
    kubectl label namespace argocd istio-injection=enabled --overwrite
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl apply -n argocd -f /vagrant/configs/argocd/resources/gateway.yaml
    kubectl apply -n argocd -f /vagrant/configs/argocd/resources/virtualservice.yaml
    cp /vagrant/configs/argocd/resources/repositories.yaml /tmp/
    ssh-keyscan gitlab.kube.local | sed -e 's/^/      /' >> /tmp/repositories.yaml
    ssh-keyscan 10.0.2.2 | sed -e 's/^/      /' >> /tmp/repositories.yaml
    kubectl apply -n argocd -f /tmp/repositories.yaml
    kubectl patch deployment -n argocd argocd-server --patch-file /vagrant/configs/argocd/patches/argocd-server.deployment.patch.yaml # patch argocd-server to avoid tls errors
    kubectl apply -n argocd -f /vagrant/configs/argocd/patches/argocd-redis.networkpolicy.patch.yaml # remove egress from argocd-redis network policy to avoid istio errors
    kubectl patch deployment -n argocd argocd-repo-server --patch-file /vagrant/configs/argocd/patches/argocd-repo-server.deployment.patch.yaml  # add hostaliases
    kubectl patch secret -n argocd argocd-secret --patch-file /vagrant/configs/argocd/patches/secret.patch.yaml # patch argocd-secret to add keycloak credential
    kubectl patch configmap -n argocd argocd-cm --patch-file /vagrant/configs/argocd/patches/configmap.patch.yaml # patch argocd-cm to add keycloak info
    kubectl patch configmap -n argocd argocd-rbac-cm --patch-file /vagrant/configs/argocd/patches/rbac.patch.yaml # patch argocd-rbac-cm add keycloak roles
    kubectl apply -n argocd -f /vagrant/configs/gitlab/applications/infra.application.yaml
    cowsay Waiting ArgoCD...
    while [[ "$(kubectl get pods -n argocd| tail -1 | awk '{print $3}')" != "Running" ]]; do
        cowsay Waiting Argocd...
        sleep 5
    done
    cowsay Argocd is running!
    # Files in the configs/argocd folder
    # Reference for ingresses: https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/

    kubectl rollout restart deployment argocd-server -n argocd  # Restart argocd-server to apply the patches
    kubectl rollout restart deployment argocd-redis -n argocd  # Restart argocd-redis to apply the patches
}


setup_haproxy() {
    cowsay Setting up HAProxy
    # https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
    # These are the external load balancer config
    export INGRESS_PORT=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
    export SECURE_INGRESS_PORT=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
    export TCP_INGRESS_PORT=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')
    export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-ingress -o jsonpath='{.items[0].status.hostIP}')

    mkdir -p /etc/haproxy/  # make sure that the folder exists
    cat /vagrant/configs/haproxy_k8s/haproxy.cfg | envsubst > /etc/haproxy/haproxy.cfg  # replace the variables from our env
    /etc/init.d/haproxy start  # start haproxy
    /etc/init.d/haproxy restart  # restart if started
}

_done() {
    ARGO_SECRET=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    cowsay "Done! ArgoCD admin secret: $ARGO_SECRET"
}

setup_kubernetes
install_helm
setup_calico
setup_istio
setup_argocd
setup_haproxy
_done
