docker-compose up -d --build
export TF_VAR_gitlab_token=MySuperSecretToken11  # password needs to be 20 chars long
# Generate a token
docker exec  infrastructure-gitlab-1 gitlab-rails runner  "token = User.find_by_username('root').personal_access_tokens.create(scopes: [:api, :sudo, :read_api, :read_user, :read_repository, :write_repository], name: 'Automation token'); token.set_token('$TF_VAR_gitlab_token'); token.save\!"
cd terraform
terraform apply -var-file=variables.tfvars -auto-approve
cd ..
vagrant up
