#!/bin/bash

IFS=$'\n'
data_arr=($(nslookup  $1 | grep 'Address: '))

IFS=' '
for line in "${data_arr[@]}"
do
    data=($line)
    echo ${data[1]}
    curl -v -m 2 "https://${data[1]}" 2>&1 | grep "Connected"
done
