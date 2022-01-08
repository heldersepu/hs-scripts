#!/bin/bash

errors=0
arr=($(aws cloudfront list-distributions | jq ".DistributionList.Items[].Aliases.Items[0]" -r))

for i in "${arr[@]}"
do
    echo "${i}"
    resp=$(curl -I "https://${i}")
    if [[ $(echo $resp | grep "x-frame-options: SAMEORIGIN" -c) = 0 ]]; then
        errors=$((errors+1))
        echo "${resp}"
    fi
    echo ""
done
if [[ $errors -ne 0 ]]; then
    echo "Errors encountered ${errors}"
    exit 1
fi
