FROM ubuntu:14.04
MAINTAINER Robert Schönthal <robert.schoenthal@gmail.com>

RUN apt-get update && apt-get -qy upgrade && apt-get install -qy python-software-properties software-properties-common unzip
RUN add-apt-repository -y ppa:nginx/stable && apt-get update

#Install Nginx
RUN apt-get install -y nginx

# Install Serf
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN mv serf /usr/bin/

# Install Supervisor
RUN apt-get install -qy supervisor
ADD /supervisord-nginx.conf /etc/supervisor/supervisord.conf

# Configure Nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 's/80/81/g' /etc/nginx/sites-enabled/default
RUN chown -R www-data:www-data /var/lib/nginx

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

EXPOSE 81

CMD ["/usr/bin/supervisord"]
