#!/bin/bash
## Script to test the api

IFS=$'\n'

key=$(cat ~/.Tribler/7.14/triblerd.conf | grep "key =")
key="${key/"key = "/""}"

port=$(cat ~/.Tribler/7.14/triblerd.conf | grep "port =")
port="${port/"port = "/""}"

curl -H "X-Api-Key: $key" -s http://localhost:$port/downloads
