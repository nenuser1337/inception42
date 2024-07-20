name = inception
all:
	@sudo mkdir -p /home/yait-oul/data/mariadb
	@sudo mkdir -p /home/yait-oul/data/wordpress
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker compose -f ./srcs/docker-compose.yml up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a -f
	@sudo rm -rf /home/yait-oul/data/wordpress
	@sudo rm -rf /home/yait-oul/data/mariadb

file: down
	@printf "Cleaning files of ${name}...\n"
	@sudo rm -rf /home/yait-oul/data/wordpress
	@sudo rm -rf /home/yait-oul/data/mariadb

fclean: down
	@printf "Total clean of all configurations docker\n"
	@docker stop $(docker ps -q) || true
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf /home/yait-oul/data/wordpress
	@sudo rm -rf /home/yait-oul/data/mariadb

.PHONY	: all build down re clean file fclean