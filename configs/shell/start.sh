. $(pwd)/configs/shell/common.sh

start_gitlab() {
    while [[ "$(curl -Ls -o /dev/null -w ''%{http_code}'' http://gitlab.kube.local)" != "200" ]]; do
        cowsay -fsmall "Waiting Gitlab..."
        sleep 5
    done
    cowsay "Generating token..."
    docker exec infra_gitlab gitlab-rails runner "token = User.find_by_username('root').personal_access_tokens.create(scopes: [:api, :sudo, :read_api, :read_user, :read_repository, :write_repository], name: 'Automation token'); token.set_token('$TF_VAR_gitlab_token'); token.save!"
}

tf_apply_configs() {
    cd terraform
    cowsay "Setting up Gitlab..."
    # terraform init
    terraform apply -var-file=variables.tfvars -auto-approve
    if [[ $? -ne 0 ]]; then
        cowsay -fmutilated "FATAL: Failed to provision Gitlab resources! Reverting changes..."
        cd ..
        sh $(pwd)/configs/shell/clean.sh
        exit 1
    fi
    cd ..
}

setup_gitlab() {
    echo $(pwd)
    docker-compose up -d --build
    start_gitlab
    tf_apply_configs
}

setup_k8s() {
    export INV_FILE=inventory.yaml
    cowsay "Provisioning Kubernetes..."
    vagrant up
    JOIN_NODE_COMMAND=$(vagrant ssh master01 -c "kubeadm token create --print-join-command")
    vagrant ssh worker01 -c "$JOIN_NODE_COMMAND"
}

main() {
    setup_gitlab &
    setup_k8s

    mkdir -p $HOME/.config/OpenLens/kubeconfigs/
    export INV_FILE=inventory.yaml
    vagrant ssh master01 -c "cat /home/vagrant/.kube/config" > $HOME/.config/OpenLens/kubeconfigs/vagrant_config
    GITLAB_PASSWORD=$(docker exec  infra_gitlab cat /etc/gitlab/initial_root_password | grep Password | tail -1)
    cowsay "Done! Gitlab initial password: $GITLAB_PASSWORD"
}


main