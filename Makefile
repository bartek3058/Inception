NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/brogalsk/data/wordpress
	@mkdir -p /home/brogalsk/data/mariadb
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

clean: down
	docker system prune -a --force

fclean: clean
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf /home/brogalsk/data/wordpress/*
	@sudo rm -rf /home/brogalsk/data/mariadb/*

re: fclean all

.PHONY: all up down stop start clean fclean re