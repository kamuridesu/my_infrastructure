# Test Environment
My files for a simple env.

# How To Run
You'll need Vagrant, Docker and Docker-Compose and Make.

Add these entries to your `/etc/hosts`:
```
127.0.0.1      kube.local
127.0.0.1      argocd.kube.local
127.0.0.1      keycloak.kube.local
127.0.0.1      gitlab.kube.local
127.0.0.1      postgres.kube.local
127.0.0.1      admin.postgres.kube.local
172.0.0.1      app.kube.local
192.168.0.100     haproxy.kube.local
```
Now, run `make start` on the folder. It'll create a virtual machine and deploy the resources. In the end, you'll get the ArgoCD password. Use it to login by accesing http://argocd.kube.local.

To stop and delete all resources, run `make clean`.
