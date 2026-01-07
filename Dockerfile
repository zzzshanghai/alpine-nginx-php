# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

ARG PHP_VERSION=php85

RUN <<EOF
apk update
apk --no-cache add bash curl icu-libs nginx openrc sudo supervisor tar ttyd tzdata ${PHP_VERSION} ${PHP_VERSION}-bcmath ${PHP_VERSION}-bz2 ${PHP_VERSION}-calendar ${PHP_VERSION}-cgi ${PHP_VERSION}-common ${PHP_VERSION}-ctype ${PHP_VERSION}-curl ${PHP_VERSION}-dom ${PHP_VERSION}-exif ${PHP_VERSION}-fileinfo ${PHP_VERSION}-fpm ${PHP_VERSION}-gd ${PHP_VERSION}-gettext ${PHP_VERSION}-gmp ${PHP_VERSION}-iconv ${PHP_VERSION}-intl ${PHP_VERSION}-mbstring ${PHP_VERSION}-openssl ${PHP_VERSION}-pear ${PHP_VERSION}-phar ${PHP_VERSION}-session ${PHP_VERSION}-simplexml ${PHP_VERSION}-soap ${PHP_VERSION}-sockets ${PHP_VERSION}-sodium ${PHP_VERSION}-sqlite3 ${PHP_VERSION}-tidy ${PHP_VERSION}-xml ${PHP_VERSION}-xmlreader ${PHP_VERSION}-xmlwriter ${PHP_VERSION}-zip
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
addgroup -g 1000 -S www-data
adduser -s /sbin/nologin -S -D -H -u 1000 www-data -G www-data
chmod 755 /var/www/html
EOF

COPY softlevel /run/openrc/softlevel
COPY supervisord.conf /root/supervisord.conf
COPY nginx/http.d/default.conf /etc/nginx/http.d/default.conf
COPY php/php-fpm.d/www.conf /etc/${PHP_VERSION}/php-fpm.d/www.conf
COPY php/php.ini /etc/${PHP_VERSION}/php.ini
COPY index.php /var/www/html/index.php
COPY tinyfilemanager/tinyfilemanager.php /var/www/html/upload.php
COPY tinyfilemanager/translation.json /var/www/html/translation.json

WORKDIR /var/www/html

EXPOSE 80/tcp

CMD ["/usr/bin/supervisord", "-c", "/root/supervisord.conf"]
