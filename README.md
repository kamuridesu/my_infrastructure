# Test Environment
My files for a simple env.

# How To Run
You'll need Vagrant, Docker and Docker-Compose and Make.

Add these entries to your `/etc/hosts`:
```
192.168.56.100 kube.local
192.168.56.100 argocd.kube.local
192.168.56.100 keycloak.kube.local
```
Now, run `make start` on the folder. It'll create a virtual machine and deploy the resources. In the end, you'll get the ArgoCD password. Use it to login by accesing http://argocd.kube.local.

To stop and delete all resources, run `make clean`.
