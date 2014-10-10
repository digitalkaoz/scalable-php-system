#!/bin/bash

docker build -t="elasticphp/serf-fpm" containers/php
docker build -t="elasticphp/serf-serf" containers/serf
docker build -t="elasticphp/serf-nginx" containers/nginx
