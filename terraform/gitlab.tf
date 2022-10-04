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

resource "gitlab_project" "argocd" {
  name             = "argocd"
  description      = "argocd gitops files"
  namespace_id     = gitlab_group.devops.id
  visibility_level = "private"
} 

resource "gitlab_user" "argocd" {
  name             = "ArgoCD"
  username         = "argocd"
  password         = "superPassword"
  email            = "argocd@kube.local"
  skip_confirmation = true
  reset_password   = false
}

resource "gitlab_group_membership" "argocd_devops" {
  group_id = gitlab_group.devops.id
  user_id = gitlab_user.argocd.id
  access_level = "maintainer"
}
# Still searching how to upload a list of files with only one resource
