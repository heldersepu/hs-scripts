source common.sh

apps=$(curl -s -X GET "$url/v1/apps?limit=200"  -H "Authorization: SSWS $okta_token" | jq -r ".[] | @base64")
for app in $apps; do
    status=$(echo $app | base64 --decode | jq ".status")
    if [ $status = "\"ACTIVE\"" ]; then
        id=$(echo $app | base64 --decode | jq ".id")
        name=$(echo $app | base64 --decode | jq ".name")
        label=$(echo $app | base64 --decode | jq ".label")
        nameTpl=$(echo $app | base64 --decode | jq ".credentials.userNameTemplate.template")
        nameTplType=$(echo $app | base64 --decode | jq ".credentials.userNameTemplate.type")
        resource=$(clean "${name}_${label}")

        usersLink=$(echo $app | base64 --decode | jq "._links.users.href" | tr -d '"')
        users=$(curl -s -X GET $usersLink  -H "Authorization: SSWS $okta_token" | jq ".[].credentials.userName")
        groupsLink=$(echo $app | base64 --decode | jq "._links.groups.href" | tr -d '"')
        groups=$(curl -s -X GET $groupsLink  -H "Authorization: SSWS $okta_token" | jq ".[].id")

        echo "# ----  terraform import okta_app_saml.$resource $id"
        echo "resource \"okta_app_saml\" \"$resource\" {"
        echo "  preconfigured_app        = $name"
        echo "  label                    = $label"
        echo "  user_name_template       = $nameTpl"
        echo "  user_name_template_type  = $nameTplType"
        
        for user in $users; do
            echo "  users {"
            echo "    id = data.okta_user.users[$user].id"
            echo "  }"
        done

        if [ -n "$groups" ]; then
            echo "  groups = ["
            for group in $groups; do
                group=$(echo $group | tr -d '"')
                groupName=$(curl -s -X GET "$url/v1/groups/$group"  -H "Authorization: SSWS $okta_token" | jq ".profile.name")
                echo "    data.okta_group.groups[$groupName].id,"
            done
            echo "  ]"
        fi
        echo "}"
        echo ""
    fi
done
