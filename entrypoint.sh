#!/bin/bash

/usr/bin/supervisord -c /root/supervisord.conf
chown -R www-data:www-data
chmod 755 /var/www/html

exec "$@"
