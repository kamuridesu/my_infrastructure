resource "gitlab_repository_file" "infra_keycloak_deployment" {
  project        = gitlab_project.argocd.id
  file_path      = "infra/keycloak/deployment.yaml"
  branch         = "main"
  content        = file(var.keycloak_deployment_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "infra_keycloak_service" {
  project        = gitlab_project.argocd.id
  file_path      = "infra/keycloak/service.yaml"
  branch         = "main"
  content        = file(var.keycloak_service_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "infra_keycloak_virtualservice" {
  project        = gitlab_project.argocd.id
  file_path      = "infra/keycloak/virtualservice.yaml"
  branch         = "main"
  content        = file(var.keycloak_virtualservice_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "infra_keycloak_gateway" {
  project        = gitlab_project.argocd.id
  file_path      = "infra/keycloak/gateway.yaml"
  branch         = "main"
  content        = file(var.keycloak_gateway_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}