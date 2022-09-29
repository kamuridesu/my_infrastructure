PATH="$PATH:/usr/games"
export PATH

update_system() {
    apt-get update
    apt-get upgrade -y
    apt-get install -y haproxy cowsay htop vim apt-transport-https ca-certificates curl software-properties-common gnupg docker docker.io
    sysctl net.bridge.bridge-nf-call-iptables=1
}

install_kubernetes() {
    touch /etc/apt/sources.list.d/kubernetes.list
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    apt-get update -y
    apt-get install -y kubelet kubeadm kubectl kubernetes-cni

    sysctl net.bridge.bridge-nf-call-iptables=1
}

install_containerd() {
    curl -L https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz --output /tmp/containerd-1.6.8-linux-amd64.tar.gz
    cd /tmp/
    tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz

    mkdir -p /usr/local/lib/systemd/system/
    curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service --output /usr/local/lib/systemd/system/containerd.service
    systemctl daemon-reload
    systemctl enable --now containerd
}

install_runc() {
    curl -L https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64 --output /tmp/runc.amd64
    cd /tmp/
    install -m 755 runc.amd64 /usr/local/sbin/runc
}

install_cni_plugins() {
    curl -L https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz --output /tmp/cni-plugins-linux-amd64-v1.1.1.tgz
    cd /tmp/
    mkdir -p /opt/cni/bin
    tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
}

setup_containerd() {
    mkdir -p /etc/containerd/
    containerd config default > /etc/containerd/config.toml
    sed -i "s/systemdCgroup = false/systemdCgroup = true/" /etc/containerd/config.toml
}

start_kube() {
    kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-cert-extra-sans=192.168.56.10
    export KUBECONFIG=/etc/kubernetes/admin.conf
    MASTER_NAME=$(kubectl get nodes | head -2 | tail -1 | awk '{print $1}')
    kubectl taint node $MASTER_NAME node-role.kubernetes.io/control-plane:NoSchedule-
}

setup_kubernetes() {
    install_containerd &
    install_runc &
    install_cni_plugins &
    install_kubernetes
    sleep 60
    setup_containerd
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
    sleep 30
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
    cowsay Waiting Istio...
    sleep 30  # wait 30 seconds for the services to be up
}

setup_argocd() {
    cowsay Setting up argocd
    # https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
    kubectl create namespace argocd
    kubectl label namespace argocd istio-injection=enabled --overwrite
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl patch deployment -n argocd argocd-server --patch-file /vagrant/configs/argocd/patch.yaml # patch argocd-server to avoid tls errors
    cowsay Waiting ArgoCD...
    sleep 30 # wait for the services to start, increase this if you want
    # Files in the configs/argocd folder
    # Reference for ingresses: https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
    kubectl apply -n argocd -f /vagrant/configs/argocd/gateway.yaml
    kubectl apply -n argocd -f /vagrant/configs/argocd/virtualservice.yaml
}

setup_keycloak() {
    # Deploy keycloak
    kubectl create namespace keycloak
    kubectl label namespace keycloak istio-injection=enabled --overwrite
    kubectl apply -n keycloak -f /vagrant/configs/keycloak/service.yaml
    kubectl apply -n keycloak -f /vagrant/configs/keycloak/deployment.yaml
    cowsay Waiting Keycloak...
    sleep 60 # keycloak takes some time to boot, ideally one or two minutes in my cpu
    kubectl apply -n keycloak -f /vagrant/configs/keycloak/gateway.yaml
    kubectl apply -n keycloak -f /vagrant/configs/keycloak/virtualservice.yaml
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
    cat /vagrant/configs/haproxy/haproxy.cfg | envsubst > /etc/haproxy/haproxy.cfg  # replace the variables from our env
    /etc/init.d/haproxy start  # start haproxy
    /etc/init.d/haproxy restart  # restart if started
}


_done() {
    ARGO_SECRET=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    cowsay "Done! ArgoCD admin secret: $ARGO_SECRET"
}


main() {
    update_system
    install_helm &
    setup_kubernetes
    setup_calico
    setup_istio
    setup_argocd
    setup_keycloak
    setup_haproxy
    _done
}

main
