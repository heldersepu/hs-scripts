#!/bin/bash
## Script to test the api

IFS=$'\n'

sed -i -e 's/ = /=/g' ~/.Tribler/7.14/triblerd.conf
. ~/.Tribler/7.14/triblerd.conf

curl -H "X-Api-Key: $key" -s http://localhost:$http_port/downloads
