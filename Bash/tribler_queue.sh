#!/bin/bash

IFS=$'\n'
H=http://localhost:8085

for row in $(curl -s  $H/downloads | jq -c .downloads[]); do
    echo ${row} | jq .name
    id=$(echo ${row} | jq .id)
    status=$(echo ${row} | jq .status)
    progress=$(echo ${row} | jq .progress)
    echo $status  $progress
    echo ""
done
