#!/bin/bash

TEAM=MyTeam

pipe_arr=($(fly -t $TEAM pipelines --json | jq .[].name))
for pipe in "${pipe_arr[@]}"
do
    echo ""
    echo $pipe
    pipeline=${pipe//\"/}
    data_arr=($(fly -t $TEAM resources -p $pipeline  --json | jq .[].name))
    for data in "${data_arr[@]}"
    do
        echo "--$data"
        fly -t $TEAM check-resource --resource=$pipeline/${data//\"/}
    done
done
