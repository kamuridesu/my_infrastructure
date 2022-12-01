resource "gitlab_repository_file" "notasite_application_notasite" {
  project        = gitlab_project.argocd.id
  file_path      = "apps/applications/notasite.application.yaml"
  branch         = "main"
  content        = file(var.notasite_application_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Add Blog"
}

resource "gitlab_repository_file" "networking_application_networking" {
  project        = gitlab_project.argocd.id
  file_path      = "apps/applications/networking.application.yaml"
  branch         = "main"
  content        = file(var.networking_application_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Add Blog"
}

