#!/bin/bash
## Script to change tribler hops if download speed is 0

IFS=$'\n'
running=1

sed -i -e 's/ = /=/g' ~/.Tribler/7.14/triblerd.conf
. ~/.Tribler/7.14/triblerd.conf

while [ $running -gt 0 ]; do
    running=0
    downloads=$(curl -H "X-Api-Key: $key" -s http://localhost:$http_port/downloads | jq -c .downloads[])
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
                curl -H "X-Api-Key: $key" -sX PATCH http://localhost:$http_port/downloads/$id --data-raw '{"anon_hops":'$hops'}'
                echo ""
            fi
            ((running++))
        fi
    done
    if [ $running != 0 ] ; then
        sleep 5
    fi
done
