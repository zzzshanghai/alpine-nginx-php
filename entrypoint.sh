#!/bin/bash


chown -R www-data:www-data
chmod 755 /var/www/html

exec "$@"
