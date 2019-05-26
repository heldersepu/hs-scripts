#!/bin/bash

MAX_QUEUE=1
H=http://localhost:8085
IFS=$'\n'

running=0
downloads=$(curl -s $H/downloads | jq -c .downloads[])
for row in $downloads; do
    echo ${row} | jq .name
    status=$(echo ${row} | jq .status)
    progress=$(echo ${row} | jq .progress)
    echo $status  $progress
    echo ""

    id=$(echo ${row} | jq .infohash | sed 's/^"\(.*\)"$/\1/')
    if [ $progress -eq 1 ] ; then
        # Stop all with progress completed
        if [ $status != '"DLSTATUS_STOPPED"' ] ; then
            resp=$(curl -sX PATCH $H/downloads/$id --data "state=stop")
        fi
    else
        # Count the running and stop if we have more than max
        if [ $status != '"DLSTATUS_STOPPED"' ] ; then
            ((running++))
            if [ $running -gt $MAX_QUEUE ] ; then
                resp=$(curl -sX PATCH $H/downloads/$id --data "state=stop")
            fi
        fi
    fi
done
