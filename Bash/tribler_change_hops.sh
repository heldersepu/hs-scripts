#!/bin/bash
## Script to change the hops if download speed is 0

MAX_QUEUE=1
H=http://localhost:52194
IFS=$'\n'


key=$(cat ~/.Tribler/7.10/triblerd.conf | grep "key =")
key="${key/"key = "/""}"
running=1

while [ $running -gt 0 ]; do
    running=0
    downloads=$(curl -H "X-Api-Key: $key" -s $H/downloads | jq -c .downloads[])
    for row in $downloads; do
        status=$(echo ${row} | jq .status)
        id=$(echo ${row} | jq .infohash | sed 's/^"\(.*\)"$/\1/')
        if [ $status == '"DLSTATUS_DOWNLOADING"' ] ; then
            speed_down=$(echo ${row} | jq .speed_down)
            if [ $speed_down -eq 0  ] ; then
                hops=$(echo ${row} | jq .hops)
                hops=$(expr $hops % 2)
                hops=$(expr $hops + 1)
                echo ${row} | jq .name
                echo "hops " $hops
                curl -H "X-Api-Key: $key" -sX PATCH $H/downloads/$id --data-raw '{"anon_hops":'$hops'}'
                echo ""
            fi
            ((running++))
        fi
    done
    sleep 5
done
