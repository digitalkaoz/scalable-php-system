#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xlb" ]; then
    echo "Not an lb. Ignoring member join."
    exit 0
fi

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`
    NODE=`echo $line | awk '{print \$1 }'`
    IP=`echo $line | awk '{print \$2 }'`

    if [ "x${ROLE}" == "php" ]; then
        sed -i '/.*bind \*:9000/a \\t\tserver '$NODE' '$IP'' /etc/haproxy/haproxy.cfg
    fi

    if [ "x${ROLE}" == "db" ]; then
        sed -i '/.*bind \*:3306/a \\t\tserver '$NODE' '$IP'' /etc/haproxy/haproxy.cfg
    fi

    if [ "x${ROLE}" == "http" ]; then
        sed -i '/.*bind \*:9100/a \\t\tserver '$NODE' '$IP'' /etc/haproxy/haproxy.cfg
    fi

done

service haproxy reload
