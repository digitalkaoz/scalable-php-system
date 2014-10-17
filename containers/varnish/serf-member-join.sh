#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xhttp_cache" ]; then
    echo "Not an cache. Ignoring member join."
    exit 0
fi

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`

    if [ "x${ROLE}" == "xweb" ]; then
        NODE=`echo $line | awk '{print \$1 }'`
        BE=`echo $line | awk '{printf "backend be_%s { .host = \"%s\"; .port=\"81\"; .connect_timeout = 5s; .first_byte_timeout = 300s; }", $1, $2}'`

        sed -i -e "s/director d1 round-robin/$BE\n&/" /etc/varnish/default.vcl
        #insert backend
        sed -i '/director d1 round-robin/a\  { .backend = be_'$NODE'; }' /etc/varnish/default.vcl
    fi
done

HANDLE=varnish-cfg-$RANDOM ; varnishadm vcl.load $HANDLE /etc/varnish/default.vcl && varnishadm vcl.use $HANDLE
