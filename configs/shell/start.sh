. $(pwd)/configs/shell/common.sh

setup_gitlab() {
    while [[ "$(curl -Ls -o /dev/null -w ''%{http_code}'' http://gitlab.kube.local)" != "200" ]]; do
        cowsay "Waiting Gitlab..."
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
        cowsay -fmutilated "FATAL: Failed to provision Gitlab resources!"
        exit 1
    fi
    cd ..
}

docker-compose up -d --build
# Generate a token
setup_gitlab
tf_apply_configs
cowsay "Provisioning minikube..."
vagrant up
GITLAB_PASSWORD=$(docker exec  infra_gitlab cat /etc/gitlab/initial_root_password | grep Password | tail -1)
cowsay "Done! Gitlab initial password: $GITLAB_PASSWORD"
