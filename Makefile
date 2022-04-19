docker:
	cp ~/.ssh/id_rsa.pub ./id_rsa.pub
	chmod +x ./docker-entrypoint.sh
	docker compose up -d

reset:
	docker compose down
	docker system prune -af