#! /bin/sh

service mariadb start

sed -i "/s/127.0.0.1/0.0.0.0/g" etc/mysql/mariadb.conf.d/50-server.cnf

cat << end > file
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'waelhamd'@'%' IDENTIFIED BY 'wassim';
GRANT ALL PRIVILEGES ON wordpress.* TO 'waelhamd'@'%';
FLUSH PRIVILEGES;
end

mariadb < file

service mariadb stop

mysqld