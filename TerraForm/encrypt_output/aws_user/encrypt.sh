#!/bin/bash

eval "$(jq -r '@sh "ID=\(.id) SE=\(.se)"')"

access=$(aws kms encrypt --key-id alias/xxxx --plaintext $ID --output text --query CiphertextBlob --region us-east-1)
secret=$(aws kms encrypt --key-id alias/xxxx --plaintext $SE --output text --query CiphertextBlob --region us-east-1)

jq -n --arg a "$access" --arg s "$secret" '{"access_value":$a,"secret_value":$s}'
