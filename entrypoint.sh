#!/usr/bin/env sh

rc-service nginx start

exec "$@"
