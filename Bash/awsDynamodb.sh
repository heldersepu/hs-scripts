#!/bin/bash


arr=($(aws dynamodb scan \
  --table-name orgCerts \
  --projection-expression  "oid" \
| jq ".Items[].oid.S" | sort | uniq))


for i in "${arr[@]}"
do
    echo "${i}"
    aws dynamodb query \
      --table-name orgCerts \
      --index-name orgIndex \
      --key-condition-expression "oid = :x" \
      --expression-attribute-values  "{\":x\":{\"S\":$i}}" \
      --projection-expression  "expires_at" \

    echo ""
done
