variable "gitlab_token" {
  description = "gitlab token"
  type        = string
}

variable "gitlab_base_url" {
  description = "gitlab base api url"
  type        = string
  default     = "https://gitlab.com/api/v4"
}

variable "keycloak_deployment_path" {
  description = "keycloak deployment path"
  type        = string
}

variable "keycloak_service_path" {
  description = "keycloak service path"
  type        = string
}

variable "keycloak_virtualservice_path" {
  description = "keycloak virtualservice path"
  type        = string
}

variable "keycloak_gateway_path" {
  description = "keycloak gateway path"
  type        = string
}

variable "keycloak_application_path" {
  description = "Keycloak argocd application"
  type        = string
}

variable "argocd_ssh_key" {
  description = "Argocd public ssh key"
  type        = string
}

variable "notasite_deployment_path" {
  description = "notasite deployment path"
  type        = string
}

variable "notasite_service_path" {
  description = "notasite service path"
  type        = string
}

variable "apps_networking_virtualservice_path" {
  description = "apps_networking virtualservice path"
  type        = string
}

variable "apps_networking_gateway_path" {
  description = "apps_networking gateway path"
  type        = string
}

variable "notasite_application_path" {
  description = "notasite argocd application"
  type        = string
}

variable "networking_application_path" {
  description = "networking argocd application"
  type = string
}

