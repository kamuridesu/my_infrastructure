gitlab_base_url              = "http://gitlab.kube.local/api/v4/"
keycloak_deployment_path     = "../configs/gitlab/infra/keycloak/deployment.yaml"
keycloak_service_path        = "../configs/gitlab/infra/keycloak/service.yaml"
keycloak_gateway_path        = "../configs/gitlab/infra/keycloak/gateway.yaml"
keycloak_virtualservice_path = "../configs/gitlab/infra/keycloak/virtualservice.yaml"
keycloak_application_path    = "../configs/gitlab/infra/applications/keycloak.application.yaml"

notasite_deployment_path     = "../configs/gitlab/apps/notasite/deployment.yaml"
notasite_service_path        = "../configs/gitlab/apps/notasite/service.yaml"
apps_networking_virtualservice_path        = "../configs/gitlab/apps/networking/gateway.yaml"
apps_networking_gateway_path = "../configs/gitlab/apps/networking/virtualservice.yaml"
notasite_application_path    = "../configs/gitlab/apps/applications/notasite.application.yaml"

networking_application_path  = "../configs/gitlab/apps/applications/networking.application.yaml"

argocd_ssh_key               = "../configs/gitlab/ssh/gitlab.pub"