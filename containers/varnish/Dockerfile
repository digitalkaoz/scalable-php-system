FROM ubuntu:14.04
MAINTAINER Robert Schönthal <robert.schoenthal@gmail.com>

RUN apt-get update && apt-get -qy upgrade && apt-get install -qy python-software-properties software-properties-common unzip

#Install Varnish
RUN apt-get install -yq varnish

# Install Serf
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN mv serf /usr/bin/
ADD serf-member-join.sh /serf-member-join.sh
ADD serf-member-leave.sh /serf-member-leave.sh
ADD serf-join.sh /serf-join.sh
RUN chmod 755 /*.sh

# Install Supervisor
RUN apt-get install -qy supervisor
ADD /supervisord-varnish.conf /etc/supervisor/supervisord.conf

# Configure Varnish
ADD /default.vcl /etc/varnish/default.vcl

EXPOSE 80

CMD ["/usr/bin/supervisord"]
