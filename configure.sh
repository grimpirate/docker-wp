#!/bin/sh

httpd -k start &

# https://stackoverflow.com/questions/63595435/installing-mysql-on-a-vm-under-alpine
mysqld --user=root --data=/data &> /dev/null &

sleep 10s

# https://wordpress.org/support/article/creating-database-for-wordpress/#using-the-mysql-client
mysql -e 'CREATE DATABASE wordpress;'
mysql -e 'GRANT ALL PRIVILEGES ON wordpress.* TO "username"@"localhost" IDENTIFIED BY "password";'
mysql -e 'FLUSH PRIVILEGES;'

exec sh