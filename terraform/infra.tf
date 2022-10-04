resource "gitlab_repository_file" "infra_application_keycloak" {
  project        = gitlab_project.argocd.id
  file_path      = "infra/applications/keycloak.application.yaml"
  branch         = "main"
  content        = file(var.keycloak_application_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}
