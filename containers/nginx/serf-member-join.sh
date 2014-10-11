#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xlb" ]; then
    echo "Not an lb. Ignoring member join."
    exit 0
fi

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`
    SERVER=`echo $line | awk '{printf "server %s:9000;", $2}'`

    if [ "x${ROLE}" == "xphp" ]; then
        sed -i '/PHP_FPM_NODES/a\		'$SERVER'' /etc/nginx/nginx.conf
    fi
done

service nginx reload
