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
    cowsay Disabling swap
    # kubelet requires swap off
    swapoff -a
    # keep swap off after reboot
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
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
    containerd config default > /etc/containerd/config.toml 
    systemctl restart containerd
}

create_dns_entries() {
    cowsay Adding /etc/hosts entries
    echo "127.0.0.1       argocd.kube.local" >> /etc/hosts
    echo "127.0.0.1       keycloak.kube.local" >> /etc/hosts
    echo "127.0.0.1       kube.local" >> /etc/hosts
    echo "10.0.2.2        gitlab.kube.local" >> /etc/hosts
    echo "10.0.2.2        postgres.kube.local" >> /etc/hosts
    echo "10.0.1.100      master" >> /etc/hosts
    echo "10.0.1.101      worker" >> /etc/hosts
}

setup_kubernetes() {
    if [[ "$PROVISIONED" == "FALSE" ]]; then
        if [[ ! -f /usr/local/lib/systemd/system/containerd.service ]]; then
            install_containerd
            setup_containerd
        fi
        if [[ ! -f /usr/local/sbin/runc ]]; then
            install_runc
        fi
        if [[ ! -f /tmp/cni-plugins-linux-amd64-v1.1.1.tgz ]]; then
            install_cni_plugins
        fi
        install_kubernetes
    fi
}

if [[ "$PROVISIONED" == "FALSE" ]]; then
    update_system
    setup_git_argocd_user
    setup_kubernetes
    create_dns_entries
fi
