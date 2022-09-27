variable "gitlab_token" {
  description = "gitlab token"
  type        = string
}

variable "gitlab_base_url" {
  description = "gitlab base api url"
  type        = string
  # default = "https://gitlab.com/api/v4"
}

variable "keycloak_deployment_path" {
  description = "deployment path"
  type        = string
}

variable "keycloak_service_path" {
  description = "service path"
  type        = string
}

variable "keycloak_virtualservice_path" {
  description = "virtualservice path"
  type        = string
}

variable "keycloak_gateway_path" {
  description = "gateway path"
  type        = string
}