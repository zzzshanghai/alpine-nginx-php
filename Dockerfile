FROM alpine:latest

RUN apk update \
  && apk --no-cache add bash curl icu-libs nginx openrc sudo supervisor tzdata \
  php85 php85-bcmath php85-bz2 php85-calendar php85-cgi php85-common php85-ctype php85-curl php85-dom php85-exif php85-fileinfo php85-fpm php85-gd php85-gettext php85-gmp php85-iconv php85-intl php85-mbstring php85-openssl php85-pear php85-phar php85-session php85-simplexml php85-soap php85-sockets php85-sodium php85-sqlite3 php85-tidy php85-xml php85-xmlreader  php85-xmlwriter php85-zip \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone

COPY softlevel /run/openrc/softlevel
COPY supervisord.conf /root/supervisord.conf
COPY nginx/http.d/default.conf /etc/nginx/http.d/default.conf
COPY index.php /var/www/html/index.php

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/root/supervisord.conf"]
