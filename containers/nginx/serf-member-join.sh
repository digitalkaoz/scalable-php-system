#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xlb" ]; then
    echo "Not an lb. Ignoring member join."
    exit 0
fi

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`
    IP=`echo $line | awk '{print \$2 }'`

    if [ "${ROLE}" == "php" ]; then
        sed -i '/#PHP_FPM_NODES/a \\tserver '$IP'' /etc/nginx/nginx.conf
    fi
done

service nginx reload
