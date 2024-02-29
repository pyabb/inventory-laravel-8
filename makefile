build:
	docker-compose build

up:
	docker-compose up -d

ps:
	docker-compose ps

stop:
	docker-compose stop

rm:
	docker-compose rm -fv

rebuild:
	make stop
	make rm
	make build
	make up

db.migrate:
	docker exec ${container} sh -c "import_db.sh"