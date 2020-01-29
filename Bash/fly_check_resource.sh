#!/bin/bash

TEAM=MyTeam
PIPE=foo

data_arr=($(fly -t $TEAM resources -p $PIPE  --json | jq .[].name))
for data in "${data_arr[@]}"
do
    echo $data
    fly -t $TEAM check-resource --resource=$PIPE/${data//\"/}
done
