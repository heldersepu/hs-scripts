#!/bin/bash
## Script to restart tribler

MAX_QUEUE=1
H=http://localhost:52194
IFS=$'\n'


key=$(cat ~/.Tribler/7.10/triblerd.conf | grep "key =")
key="${key/"key = "/""}"
downloads=$(curl -H "X-Api-Key: $key" -s $H/downloads | jq -c .downloads[])
for row in $downloads; do
    status=$(echo ${row} | jq .status)
    id=$(echo ${row} | jq .infohash | sed 's/^"\(.*\)"$/\1/')
    if [ $status == '"DLSTATUS_DOWNLOADING"' ] ; then
        speed_down=$(echo ${row} | jq .speed_down)
        echo $status  $speed_down
        if [ $speed_down -eq 0  ] ; then
            curl -H "X-Api-Key: $key" -sX PUT $H/shutdown
            sleep 5
            pkill --signal SIGTERM tribler
            sleep 5
            tribler &
        fi
    fi
done
