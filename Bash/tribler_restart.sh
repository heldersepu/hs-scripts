#!/bin/bash
## Script to restart tribler

IFS=$'\n'
MAX_QUEUE=1

sed -i -e 's/ = /=/g' ~/.Tribler/7.14/triblerd.conf
. ~/.Tribler/7.14/triblerd.conf

downloads=$(curl -H "X-Api-Key: $key" -s http://localhost:$http_port/downloads | jq -c .downloads[])
for row in $downloads; do
    status=$(echo ${row} | jq .status)
    id=$(echo ${row} | jq .infohash | sed 's/^"\(.*\)"$/\1/')
    if [ $status == '"DLSTATUS_DOWNLOADING"' ] ; then
        speed_down=$(echo ${row} | jq .speed_down)
        echo $status  $speed_down
        if [ $speed_down -eq 0  ] ; then
            curl -H "X-Api-Key: $key" -sX PUT http://localhost:$http_port/shutdown
            sleep 5
            pkill --signal SIGTERM tribler
            sleep 5
            tribler &
        fi
    fi
done
