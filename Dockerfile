FROM alpine

RUN apk add --no-cache apache2 php-apache2 php-dom php-exif php-fileinfo php8-pecl-imagick php-iconv php-intl php-mysqli mysql mysql-client phpmyadmin
RUN rm -rf /var/cache/apk/*

RUN mkdir /run/mysqld
RUN mysql_install_db

RUN chown -R apache:apache /usr/share/webapps/phpmyadmin
RUN chown -R apache:apache /etc/phpmyadmin

WORKDIR /var/www/localhost
RUN rm -rf htdocs/*
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xf latest.tar.gz --strip-components=1 --directory htdocs
RUN chown -R apache:apache htdocs
RUN chmod -R 0777 htdocs

RUN rm latest.tar.gz
RUN rm -rf htdocs/wp-content/plugins/akismet
RUN rm htdocs/wp-content/plugins/hello.php
RUN rm -rf htdocs/wp-content/themes/twentytwenty
RUN rm -rf htdocs/wp-content/themes/twentytwentyone

WORKDIR /
ADD configure.sh /
RUN chmod +x configure.sh

VOLUME ["/var/www/localhost/htdocs"]

CMD ["./configure.sh"]

EXPOSE 80