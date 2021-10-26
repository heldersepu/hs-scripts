#!/bin/bash
## Script to keep a queue on tribbler

MAX_QUEUE=1
H=http://localhost:52194/downloads
IFS=$'\n'

running=0
arr_queue=()
key=$(cat ~/.Tribler/7.10/triblerd.conf | grep "key =")
key="${key/"key = "/""}"
downloads=$(curl -H "X-Api-Key: $key" -s $H | jq -c .downloads[])
for row in $downloads; do
    echo ${row} | jq .name
    status=$(echo ${row} | jq .status)
    progress=$(echo ${row} | jq .progress)
    echo $status  $progress
    echo ""

    id=$(echo ${row} | jq .infohash | sed 's/^"\(.*\)"$/\1/')
    if [ "$progress" == "1" ] ; then
        # Stop all with progress completed
        if [ $status != '"DLSTATUS_STOPPED"' ] ; then
            resp=$(curl -H "X-Api-Key: $key" -sX PATCH $H/$id --data-raw '{"state":"stop"}')
        fi
    else
        # Count the running and stop if we have more than max
        if [ $status != '"DLSTATUS_STOPPED"' ] ; then
            ((running++))
            if [ $running -gt $MAX_QUEUE ] ; then
                resp=$(curl -H "X-Api-Key: $key" -sX PATCH $H/$id --data-raw '{"state":"stop"}')
            fi
        else
            arr_queue+=($id)
        fi
    fi
done

# If we have running less than max we start
if [ $running -lt $MAX_QUEUE ] ; then
    for queue in $arr_queue; do
        resp=$(curl -H "X-Api-Key: $key" -sX PATCH $H/$queue --data-raw '{"state":"resume"}')
        ((running++))
        if [ $running -ge $MAX_QUEUE ] ; then break; fi
    done
fi
