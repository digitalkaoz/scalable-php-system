FROM ubuntu:14.04
MAINTAINER Robert Schönthal <robert.schoenthal@gmail.com>

RUN apt-get update && apt-get -qy upgrade && apt-get install -qy unzip

# Install PHP-FPM
RUN apt-get -qy install php5 php5-fpm php5-gd php5-ldap php5-sqlite php5-pgsql php-pear php5-mysql php5-mcrypt php5-xcache php5-xmlrpc

# Install Serf
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN mv serf /usr/bin/

# Install Supervisor
RUN apt-get install -qy supervisor
ADD /supervisord-php-fpm.conf /etc/supervisor/supervisord.conf

# Configure PHP
RUN sed -i '/daemonize /c daemonize = no' /etc/php5/fpm/php-fpm.conf
RUN sed -i '/error_log = \/var\/log\/php5-fpm\.log /c error_log = /dev/stdout' /etc/php5/fpm/php-fpm.conf
RUN sed -i '/^listen /c listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/fpm/pool.d/www.conf

# Default PHP File
RUN mkdir -p /srv/http && echo "<?php phpinfo(); ?>" > /srv/http/index.php
RUN chown -R www-data:www-data /srv/http

VOLUME /srv/http

EXPOSE 9000

CMD ["/usr/bin/supervisord"]
