clean:
	sh ./configs/shell/clean.sh

start:
	sh ./configs/shell/start.sh

reload_kube:
	vagrant provision

wipe:
	cowsay -fskeleton "Removind Docker volumes..." && sudo rm -rf ./data/*