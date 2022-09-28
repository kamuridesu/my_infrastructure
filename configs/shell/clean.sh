. $(pwd)/configs/shell/common.sh
cowsay -fskeleton "Removing Gitlab resources... "
cd terraform
terraform destroy -var-file=variables.tfvars -auto-approve
rm -rf *.tfstate*
cd ..
docker-compose down
sudo rm -rf gitlab
cowsay -fskeleton "Removing minikube VM..."
vagrant destroy -f
cowsay -fskeleton "Done!"