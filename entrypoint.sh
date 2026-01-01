#!/usr/bin/env sh

rc-update add nginx
rc-service nginx start

exec "$@"
