FROM ubuntu:14.04
MAINTAINER Robert Schönthal <robert.schoenthal@gmail.com>

RUN apt-get update && apt-get -qy upgrade && apt-get install -qy python-software-properties software-properties-common unzip

#Install Redis
RUN apt-get update && apt-get install -yq redis-server
RUN sed -i '/daemonize /c daemonize = no' /etc/redis/redis.conf
#RUN sed -e "\$acluster-enabled yes" /etc/redis/redis.conf

# Install Serf
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN mv serf /usr/bin/
ADD serf-join.sh /serf-join.sh
RUN chmod 755 /*.sh

# Install Supervisor
RUN apt-get install -qy supervisor
ADD /supervisord-redis.conf /etc/supervisor/supervisord.conf

EXPOSE 6379

CMD ["/usr/bin/supervisord"]
