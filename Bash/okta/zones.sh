source common.sh

zones=$(curl -s -X GET "$url/v1/zones"  -H "Authorization: SSWS $okta_token" | jq -r ".[] | @base64")
for zone in $zones; do
    status=$(echo $zone | base64 --decode | jq ".status")
    if [ $status = "\"ACTIVE\"" ]; then
        id=$(echo $zone | base64 --decode | jq ".id")
        name=$(echo $zone | base64 --decode | jq ".name")
        type=$(echo $zone | base64 --decode | jq ".type")
        resource=$(clean "${name}_${type}")

        gateways=$(echo $zone | base64 --decode | jq -c ".gateways")
        proxies=$(echo $zone | base64 --decode | jq -c ".proxies")

        echo "# ----  terraform import okta_app_saml.$resource $id"
        echo "resource \"okta_network_zone\" \"$resource\" {"
        echo "  name        = $name"
        echo "  type        = $type"

        if [ "$gateways" != "null" ]; then
            echo "  gateways = ["
            for gateway in $(echo $gateways | jq -r ".[].value"); do
                echo "    \"$gateway\""
            done
            echo "  ]"
        fi
        
        if [ "$proxies" != "null" ]; then
            echo "  proxies  = ["
            for proxy in $(echo $proxies | jq -r ".[].value"); do
                echo "    $proxy"
            done
            echo "  ]"
        fi
        echo "}"
        echo ""
    fi
done
