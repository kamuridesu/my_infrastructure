PATH="$PATH:/usr/games"
export PATH

which kubeadm 2>&1 > /dev/null
PROVISIONED="FALSE"
if [[ -f /etc/kubernetes/admin.conf ]]; then
    PROVISIONED="TRUE"
    export KUBECONFIG=/etc/kubernetes/admin.conf
fi

update_system() {
    apt-get update
    apt-get upgrade -y
    apt-get install -y haproxy cowsay htop vim apt-transport-https ca-certificates curl software-properties-common gnupg docker docker.io git
    sysctl net.bridge.bridge-nf-call-iptables=1
}

setup_git_argocd_user() {
    git config --global user.name "argocd"
    git config --global user.email "argocd@kube.local"
    mkdir -p ~/.ssh/
    cp /vagrant/configs/gitlab/ssh/config /vagrant/configs/gitlab/ssh/gitlab ~/.ssh
}

install_kubernetes() {
    cowsay Installing Kubernetes...
    touch /etc/apt/sources.list.d/kubernetes.list
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    apt-get update -y
    apt-get install -y kubelet kubeadm kubectl kubernetes-cni

    sysctl net.bridge.bridge-nf-call-iptables=1
    sleep 30
}

install_containerd() {
    cowsay Installing containerd...
    curl -L https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz --output /tmp/containerd-1.6.8-linux-amd64.tar.gz
    cd /tmp/
    tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz

    mkdir -p /usr/local/lib/systemd/system/
    curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service --output /usr/local/lib/systemd/system/containerd.service
    systemctl daemon-reload
    systemctl enable --now containerd
}

install_runc() {
    cowsay Installing runc...
    curl -L https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64 --output /tmp/runc.amd64
    cd /tmp/
    install -m 755 runc.amd64 /usr/local/sbin/runc
}

install_cni_plugins() {
    cowsay Installing cni plugins...
    curl -L https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz --output /tmp/cni-plugins-linux-amd64-v1.1.1.tgz
    cd /tmp/
    mkdir -p /opt/cni/bin
    tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
}

setup_containerd() {
    cowsay Setting up containerd
    mkdir -p /etc/containerd/
    containerd config default > /etc/containerd/config.toml
    sed -i "s/systemdCgroup = false/systemdCgroup = true/" /etc/containerd/config.toml
}

start_kube() {
    if [[ "$PROVISIONED" == "FALSE" ]]; then
        cowsay Starting kubeadm
        kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-cert-extra-sans=10.0.1.100
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
    if [[ "$PROVISIONED" == "FALSE" ]]; then
        install_containerd
        setup_containerd
        install_runc
        install_cni_plugins
        install_kubernetes
    fi
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

create_dns_entries() {
    cowsay Adding /etc/hosts entries
    echo "127.0.0.1    argocd.kube.local" >> /etc/hosts
    echo "127.0.0.1    keycloak.kube.local" >> /etc/hosts
    echo "127.0.0.1    kube.local" >> /etc/hosts
    echo "10.0.2.2     gitlab.kube.local" >> /etc/hosts
    echo "10.0.2.2     postgres.kube.local" >> /etc/hosts
}

_done() {
    ARGO_SECRET=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    cowsay "Done! ArgoCD admin secret: $ARGO_SECRET"
}

main() {
    if [[ "$PROVISIONED" == "FALSE" ]]; then
        update_system
        setup_git_argocd_user
        install_helm &
        setup_kubernetes
        create_dns_entries
        setup_calico
        setup_istio
        setup_argocd
    fi
    setup_haproxy
    _done
}
main
