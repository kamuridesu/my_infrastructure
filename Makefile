clean:
	sh ./configs/shell/clean.sh

start:
	export ENV_FILE=inventory.yaml
	sh ./configs/shell/start.sh

reload_kube:
	vagrant provision

wipe:
	cowsay -fskeleton "Deleting Docker volumes..."
	sudo rm -rf ./data/*

backup_db:
	docker exec -it -u postgres infra_postgres pg_dumpall > ./configs/postgres/backup.sql

restore_db:
	docker cp ./configs/postgres/backup.sql infra_postgres:/var/lib/postgresql
	docker exec -it -u postgres infra_postgres psql -f /var/lib/postgresql/backup.sql
