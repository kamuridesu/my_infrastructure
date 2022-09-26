apt-get update
apt-get upgrade -y
apt-get install -y docker docker.io curl haproxy cowsay
# setup cowsay
PATH="$PATH:/usr/games"
export PATH

# https://helm.sh/docs/intro/install/#from-script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
cowsay Installing Helm
chmod 700 get_helm.sh
./get_helm.sh

# https://minikube.sigs.k8s.io/docs/start/
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
cowsay Installing minikube
install minikube-linux-amd64 /usr/local/bin/minikube
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sysctl fs.protected_regular=0  # avoid some permissions issues
minikube config set driver docker  # explicitly set driver to docker
cowsay Stating minikube
minikube start --force --memory=3200 --cpus=3
minikube addons enable ingress  # enable ingress
kubectl config use-context minikube

cowsay Setting up Istio
# Start from here: https://istio.io/latest/docs/setup/install/helm/
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
kubectl create namespace istio-system
helm install istio-base istio/base -n istio-system
helm install istiod istio/istiod -n istio-system --wait
# On step for, from here: https://istio.io/latest/docs/setup/additional-setup/gateway/
cowsay Creating Istio ingress gateway
kubectl create namespace istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled # https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/#automatic-sidecar-injection
helm install istio-ingressgateway istio/gateway -n istio-ingress
cowsay Waiting Istio...
sleep 30  # wait 30 seconds for the services to be up
cowsay Exposing minikube via load balancer
nohup minikube tunnel &

cowsay Setting up argocd
# https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
kubectl create namespace argocd
kubectl label namespace argocd istio-injection=enabled --overwrite
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch deployment -n argocd argocd-server --patch-file /vagrant/configs/argocd/patch.yaml # patch argocd-server to avoid tls errors
cowsay Waiting ArgoCD...
sleep 30 # wait for the services to start, increase this if want
# Files in the configs/argocd folder
# Reference for ingresses: https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
kubectl apply -n argocd -f /vagrant/configs/argocd/gateway.yaml
kubectl apply -n argocd -f /vagrant/configs/argocd/virtualservice.yaml


# Deploy keycloak
kubectl create namespace keycloak
kubectl label namespace keycloak istio-injection=enabled --overwrite
kubectl apply -n keycloak -f /vagrant/configs/keycloak/service.yaml
kubectl apply -n keycloak -f /vagrant/configs/keycloak/deployment.yaml
cowsay Waiting Keycloak...
sleep 60 # keycloak takes some time to boot, ideally one or two minutes in my cpu
kubectl apply -n keycloak -f /vagrant/configs/keycloak/gateway.yaml
kubectl apply -n keycloak -f /vagrant/configs/keycloak/virtualservice.yaml

cowsay Setting up HAProxy
# https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
# These are the external load balancer config
export INGRESS_HOST=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n istio-ingress get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')
mkdir -p /etc/haproxy/  # make sure that the folder exists
cat /vagrant/configs/haproxy/haproxy.cfg | envsubst > /etc/haproxy/haproxy.cfg  # replace the variables from our env
/etc/init.d/haproxy start  # start haproxy
/etc/init.d/haproxy restart  # restart if started

ARGO_SECRET=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
cowsay "Done! ArgoCD admin secret: $ARGO_SECRET"
