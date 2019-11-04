source common.sh

origins=$(curl -s -X GET "$url/v1/trustedOrigins"  -H "Authorization: SSWS $okta_token" | jq -r ".[] | @base64")
for origin in $origins; do
    status=$(echo $origin | base64 --decode | jq ".status")
    if [ $status = "\"ACTIVE\"" ]; then
        id=$(echo $origin | base64 --decode | jq ".id")
        name=$(echo $origin | base64 --decode | jq ".name")
        orig=$(echo $origin | base64 --decode | jq ".origin")
        resource=$(clean "${name}")

        scopes=$(echo $origin | base64 --decode | jq -c ".scopes")

        echo "# ----  terraform import okta_trusted_origin.$resource $id"
        echo "resource \"okta_trusted_origin\" \"$resource\" {"
        echo "  name   = $name"
        echo "  origin = $orig"
        if [ "$scopes" != "null" ]; then
            echo "  scopes = ["
            for scope in $(echo $scopes | jq -r ".[].type"); do
                echo "    \"$scope\""
            done
            echo "  ]"
        else
            echo "  scopes = []"
        fi
        echo "}"
        echo ""
    fi
done
