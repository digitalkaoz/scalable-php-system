FROM ubuntu:14.04
MAINTAINER Robert Schönthal <robert.schoenthal@gmail.com>

RUN apt-get update && apt-get -qy upgrade && apt-get install -qy unzip

# Install Serf
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN rm serf.zip
RUN mv serf /usr/bin/

# Install Supervisor
RUN apt-get install -qy supervisor
ADD /supervisord-serf.conf /etc/supervisor/supervisord.conf

EXPOSE 7946 7373
CMD ["/usr/bin/supervisord"]
