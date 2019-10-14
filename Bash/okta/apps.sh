url="https://myapp.oktapreview.com/api"

apps=$(curl -s -X GET "$url/v1/apps?limit=200"  -H "Authorization: SSWS $okta_token" | jq -r ".[] | @base64")
for app in $apps; do
    status=$(echo $app | base64 --decode | jq ".status")
    if [ $status = "\"ACTIVE\"" ]; then
        id=$(echo $app | base64 --decode | jq ".id")
        name=$(echo $app | base64 --decode | jq ".name")
        label=$(echo $app | base64 --decode | jq ".label")

        resource="${name}_${label}"
        resource=$(echo $resource | tr '[:upper:]' '[:lower:]')
        resource=$(echo $resource | tr -d '"')
        resource="${resource//  /_}"
        resource="${resource// /_}"
        resource="${resource/:/_}"
        resource="${resource/./_}"
        resource="${resource/@/_}"
        resource="${resource/(/_}"
        resource="${resource/)/_}"
        resource="${resource/_-_/_}"
        resource="${resource/\"_\"/_}"
        resource="${resource/__/_}"


        echo "# ----  terraform import okta_user.$resource $id"
        echo "resource \"okta_user\" \"$resource\" {"
        echo "}"
        echo ""
    fi
done

