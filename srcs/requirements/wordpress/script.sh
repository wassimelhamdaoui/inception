#!/bin/sh.

# Wait until the MariaDB server is reachable
while ! mysqladmin ping -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 1
done

# Create a directory /run/php
mkdir -p /run/php

# Modify the PHP-FPM configuration to listen on port 9000
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Download and set up WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Change the working directory to /var/www/html
cd /var/www/html

# Set permissions on /var/www/html
chmod 777 /var/www/html

# If wp-config.php doesn't exist, set up WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
    # Use WP-CLI to download WordPress core files
    wp core download --allow-root

    # Use WP-CLI to configure the database settings
    wp core config --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --allow-root

    # Use WP-CLI to install WordPress
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

    # Use WP-CLI to create additional user
    wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=author --allow-root
fi

# Start PHP-FPM with PHP 7.4 in the foreground
php-fpm7.4 -F
