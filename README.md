# Scalable PHP Infrastructure

based on docker

## Whats inside?

* [php-fpm](http://php-fpm.org/) for processing PHP
* [nginx](http://nginx.org/) as the webserver of choice
* [varnish](https://www.varnish-cache.org/) as http cache **todo**
* [redis](http://redis.io/) for application caches **todo clusterize**
* [mysql with fabric](http://dev.mysql.com/downloads/fabric/) for relational Data Storage **todo**
* [elasticsearch](http://www.elasticsearch.org/) for unrelational Data Storage


* [haproxy](http://www.haproxy.org/) for loadbalancing **needed? todo**

##Installation

Install [docker](https://www.docker.com/) and [fig](http://www.fig.sh/).

Build the Images

```
$ fig build
```

##Usage

Create and Run Containers with fig

```
$ fig up -d
```

###Scaling

scaling out could be done very easily at every level of the system:

```
$ fig scale php=5 #5 php nodes
$ fig scale web=2 #2 nginx nodes
```
