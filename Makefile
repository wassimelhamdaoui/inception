
all:
	@docker compose -f ./srcs/docker-compose.yml up --build -d

dir:
	@mkdir /home/wassim/data/db /home/wassim/data/wordpress

down:
	@docker compose -f ./srcs/docker-compose.yml down


clean: down
	@sudo rm -rf /home/wassim/data/db /home/wassim/data/wordpress
	@docker volume rm srcs_mariadb-volume srcs_wordpress-data