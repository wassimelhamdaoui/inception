FROM debian:bullseye

EXPOSE 9000
#need to install php to execute wp-cli.phar
RUN apt update && apt install -y wget curl php php-fpm php-mysql

COPY script.sh /bin/script.sh

COPY wwww.conf /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/wwww/html

CMD [ "bash" ,"/bin/script.sh"]