. $(pwd)/configs/shell/common.sh
cowsay -fskeleton "Removing Gitlab resources... "
cd terraform
terraform destroy -var-file=variables.tfvars -auto-approve
rm -rf *.tfstate*
cd ..
docker-compose down
cowsay -fskeleton "Removing K8S VM..."
vagrant destroy -f
cowsay -fskeleton "Done!"
