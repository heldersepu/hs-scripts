#!/bin/bash

if [ "${nslookup_record}" != "" ]; then
    for tries in $(seq 1 30); do
        if [[ $(nslookup ${nslookup_record} | egrep -c "(can't find|timed out)") == 0 ]]; then
            echo "GOOD TO GO"
            exit 0;
        fi
        echo "Invalid response, will try again in 10 seconds. ($tries/30)"
        sleep 10
    done
    echo "ERROR !"
    exit 1;
fi