#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xhttp_cache" ]; then
    echo "Not an cache. Ignoring member leave"
    exit 0
fi

while read line; do
    NODE=`echo $line | awk '{print \$2 }'`
    sed -i'' "/${NODE} /d" /etc/varnish/default.vcl
done

HANDLE=varnish-cfg-$RANDOM ; varnishadm vcl.load $HANDLE /etc/varnish/default.vcl && varnishadm vcl.use $HANDLE
