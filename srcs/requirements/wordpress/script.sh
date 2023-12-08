#!/bin/sh.

while ! mysqladmin ping -h "mariadb" -u "waelhamd" -p"123" --silent; do
    sleep 1
done
mkdir /run/php
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
chmod 777 /var/www/html
if [ ! -f /var/www/html/wp-config.php ]; then
wp core download --allow-root
wp core config --dbname=wordpress --dbuser=waelhamd --dbpass=wassim --dbhost=mariadb --allow-root
wp core install  --url=waelhamd.42.fr --title=wptitle --admin_user=waelhamd --admin_password=123 --admin_email=wassim.elhamdaoui@uit.ac.ma --allow-root
wp user create "wassm" "wassim@gmail.com" --user_pass=userpassword --role=author --allow-root
fi
php-fpm7.4 -F
