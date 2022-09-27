terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.18.0"
    }
  }
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = var.gitlab_base_url
  insecure = false
}

resource "gitlab_group" "devops" {
  name        = "DevOps"
  path        = "devops"
  description = "DevOps IAC Files"
}

resource "gitlab_project" "keycloak" {
  name             = "keycloak"
  description      = "keycloak iac files"
  namespace_id     = gitlab_group.devops.id
  visibility_level = "private"
}

# Still searching how to upload a list of files with only one resource
resource "gitlab_repository_file" "deployment" {
  project        = gitlab_project.keycloak.id
  file_path      = "deployment.yaml"
  branch         = "main"
  content        = file(var.keycloak_deployment_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "service" {
  project        = gitlab_project.keycloak.id
  file_path      = "service.yaml"
  branch         = "main"
  content        = file(var.keycloak_service_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "virtualservice" {
  project        = gitlab_project.keycloak.id
  file_path      = "virtualservice.yaml"
  branch         = "main"
  content        = file(var.keycloak_virtualservice_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}

resource "gitlab_repository_file" "gateway" {
  project        = gitlab_project.keycloak.id
  file_path      = "gateway.yaml"
  branch         = "main"
  content        = file(var.keycloak_gateway_path)
  author_email   = "gitlab@gitlab.com"
  author_name    = "Terraform"
  commit_message = "Initial commit"
}
