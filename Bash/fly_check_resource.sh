#!/bin/bash

TEAM=MyTeam
PIPE=foo
MATCH=bar

data_arr=($(fly -t $TEAM get-pipeline -p $PIPE | grep "name: $MATCH"))
for data in "${data_arr[@]}"
do
    if [[ $data = *"$MATCH"* ]]; then
        echo $data
        fly -t $TEAM check-resource --resource=$PIPE/$data
        sleep 5
    fi
done
