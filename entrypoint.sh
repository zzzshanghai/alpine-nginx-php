#!/bin/sh

chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html
/usr/bin/supervisord -c /root/supervisord.conf

exec "$@"
