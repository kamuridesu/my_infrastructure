resource "gitlab_repository_file" "apps_notasite_deployment" {
  project        = gitlab_project.argocd.id
  file_path      = "apps/notasite/deployment.yaml"
  branch         = "main"
  content        = file(var.notasite_deployment_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Add Blog"
}

resource "gitlab_repository_file" "apps_notasite_service" {
  project        = gitlab_project.argocd.id
  file_path      = "apps/notasite/service.yaml"
  branch         = "main"
  content        = file(var.notasite_service_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "apps_networking_virtualservice" {
  project        = gitlab_project.argocd.id
  file_path      = "apps/networking/virtualservice.yaml"
  branch         = "main"
  content        = file(var.apps_networking_virtualservice_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "apps_networking_gateway" {
  project        = gitlab_project.argocd.id
  file_path      = "apps/networking/gateway.yaml"
  branch         = "main"
  content        = file(var.apps_networking_gateway_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}
