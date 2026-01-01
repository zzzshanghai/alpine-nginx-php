#!/bin/sh

nginx -g "daemon off;"
php-fpm85 -d

exec "$@"
