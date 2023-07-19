FROM debian:bullseye

#need to install php to execute wp-cli.phar
RUN apt update && apt install -y wget curl php php-fpm php-mysql mariadb-client

COPY script.sh /bin/script.sh

# COPY wwww.conf /etc/php/7.4/fpm/pool.d

CMD [ "bash" ,"/bin/script.sh"]