FROM ubuntu:14.04
MAINTAINER Robert Schönthal <robert.schoenthal@gmail.com>

RUN apt-get update && apt-get -qy upgrade && apt-get install -qy python-software-properties software-properties-common unzip

#Install Java
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -yq install oracle-java7-installer && update-java-alternatives -s java-7-oracle

#Install elasticsearch
RUN wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN add-apt-repository -y 'deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main' && apt-get update
RUN apt-get update && apt-get install -yq elasticsearch
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml
RUN /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head
RUN /usr/share/elasticsearch/bin/plugin --install lukas-vlcek/bigdesk

# Install Serf
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN mv serf /usr/bin/
ADD serf-join.sh /serf-join.sh
RUN chmod 755 /*.sh

# Install Supervisor
RUN apt-get install -qy supervisor
ADD /supervisord-elasticsearch.conf /etc/supervisor/supervisord.conf

EXPOSE 9200 9300

VOLUME ["/data"]

CMD ["/usr/bin/supervisord"]
