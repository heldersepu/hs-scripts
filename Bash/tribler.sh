#!/bin/bash
## Script to change the hops if download speed is 0

H=http://localhost:52194
IFS=$'\n'

key=$(cat ~/.Tribler/7.10/triblerd.conf | grep "key =")
key="${key/"key = "/""}"
echo $key
curl -H "X-Api-Key: $key" -s $H/downloads | jq -c .downloads[]
