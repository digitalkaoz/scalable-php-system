#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xweb" ]; then
    echo "Not an nginx. Ignoring member join."
    exit 0
fi

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`

    if [ "x${ROLE}" == "xphp" ]; then
        IP=`echo $line | awk '{print \$2 }'`
        sed -i '/PHP_FPM_NODES/a\          server '$IP':9000;' /etc/nginx/nginx.conf
    fi
done

service nginx reload
