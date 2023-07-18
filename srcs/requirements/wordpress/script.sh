#!/bin/sh.

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#to use wp insted of php wp-cli.phar
chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp

wp core download --allow-root

chmod -R 0777 wp-content
chown -R www-data:www-data ../

wp core config --dbname=wordpress --dbuser=waelhamd --dbpass=wassim --dbhost=mariadb --allow-root


mkdir /run/php/

sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g" /etc/php/7.4/fpm/pool.d/www.conf

php-fpm7.4 -F