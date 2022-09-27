docker-compose up -d --build
cowsay Waiting Gitlab...
sleep 5
export TF_VAR_gitlab_token=MySuperSecretToken11  # password needs to be 20 chars long
# Generate a token
while [[ "$(curl -Ls -o /dev/null -w ''%{http_code}'' http://localhost)" != "200" ]]; do
    sleep 5
done
cowsay Generating token...
docker exec  infrastructure-gitlab-1 gitlab-rails runner  "token = User.find_by_username('root').personal_access_tokens.create(scopes: [:api, :sudo, :read_api, :read_user, :read_repository, :write_repository], name: 'Automation token'); token.set_token('$TF_VAR_gitlab_token'); token.save!"
cd terraform
terraform init
terraform apply -var-file=variables.tfvars -auto-approve
cd ..
cowsay Provisioning minikube...
vagrant up
GITLAB_PASSWORD=$(docker exec  infrastructure-gitlab-1 cat /etc/gitlab/initial_root_password | grep Password | tail -1)
cowsay "Done! Gitlab initial password: $GITLAB_PASSWORD"