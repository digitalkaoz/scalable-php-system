#!/bin/bash
if [ "x${SERF_SELF_ROLE}" != "xlb" ]; then
    echo "Not an lb. Ignoring member leave"
    exit 0
fi

while read line; do
    IP=`echo $line | awk '{print \$2 }'`
    sed -i'' "/${IP} /d" /etc/nginx/nginx.conf
done

service nginx reload
