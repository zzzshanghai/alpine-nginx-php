#!/bin/sh

chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html
chmod 755 /var/www/html/index.php
chmod 755 /var/www/html/upload.php

exec "$@"
