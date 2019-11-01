source common.sh

declare -a poltypes=("OKTA_SIGN_ON" "PASSWORD" "MFA_ENROLL" "IDP_DISCOVERY") # "OAUTH_AUTHORIZATION_POLICY" <- ERR
for ptype in "${poltypes[@]}"; do
    echo $ptype
    policies=$(curl -s -X GET "$url/v1/policies?type=$ptype"  -H "Authorization: SSWS $okta_token" | jq -r ".[] | @base64")
    for pol in $policies; do
        status=$(echo $zone | base64 --decode | jq ".status")
        if [ $status = "\"ACTIVE\"" ]; then
            system=$(echo $zone | base64 --decode | jq ".system")
            if [ $system = "false" ]; then
                id=$(echo $pol | base64 --decode | jq ".id")
                name=$(echo $zone | base64 --decode | jq ".name")
                resource=$(clean "${name}")

                echo "# ----  terraform import okta_.$resource $id"
            fi
        fi
    done
done
