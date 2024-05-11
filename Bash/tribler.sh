#!/bin/bash
## Script to change the tribler hops if download speed is 0

IFS=$'\n'

sed -i -e 's/ = /=/g' ~/.Tribler/7.14/triblerd.conf
. ~/.Tribler/7.14/triblerd.conf

echo $key
curl -H "X-Api-Key: $key" -s http://localhost:$http_port/downloads | jq -c .downloads
