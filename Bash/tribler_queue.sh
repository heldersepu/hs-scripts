#!/bin/bash
## Script to keep a queue on tribler

IFS=$'\n'
MAX_QUEUE=1
running=1

sed -i -e 's/ = /=/g' ~/.Tribler/7.14/triblerd.conf
. ~/.Tribler/7.14/triblerd.conf

while [ $running -gt 0 ]; do
    running=0
    arr_queue=()
    downloads=$(curl -H "X-Api-Key: $key" -s http://localhost:$http_port/downloads | jq -c .downloads[])
    for row in $downloads; do
        name=$(echo ${row} | jq .name)
        status=$(echo ${row} | jq .status)
        progress=$(echo ${row} | jq .progress)


        id=$(echo ${row} | jq .infohash | sed 's/^"\(.*\)"$/\1/')
        if [ "$progress" == "1" ] ; then
            # Stop all with progress completed
            if [ $status != '"STOPPED"' ] ; then
                resp=$(curl -H "X-Api-Key: $key" -sX PATCH http://localhost:$http_port/downloads/$id --data-raw '{"state":"stop"}')
                echo "STOPPING $name"
            fi
        else
            # Count the running and stop if we have more than max
            if [ $status != '"STOPPED"' ] ; then
                ((running++))
                if [ $running -gt $MAX_QUEUE ] ; then
                    resp=$(curl -H "X-Api-Key: $key" -sX PATCH http://localhost:$http_port/downloads/$id --data-raw '{"state":"stop"}')
                    echo "STOPPING $name"
                fi
            else
                arr_queue+=($id)
            fi
        fi
    done

    # If we have running less than max we start
    if [ $running -lt $MAX_QUEUE ] ; then
        for queue in $arr_queue; do
            resp=$(curl -H "X-Api-Key: $key" -sX PATCH http://localhost:$http_port/downloads/$queue --data-raw '{"state":"resume"}')
            ((running++))
            if [ $running -ge $MAX_QUEUE ] ; then break; fi
        done
    fi
    if [ $running != 0 ] ; then
        sleep 5
    fi
done
