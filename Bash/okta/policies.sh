source common.sh

declare -a poltypes=("OKTA_SIGN_ON" "MFA_ENROLL")
for ptype in "${poltypes[@]}"; do
    echo $ptype
    policies=$(curl -s -X GET "$url/v1/policies?type=$ptype"  -H "Authorization: SSWS $okta_token" | jq -r ".[] | @base64")
    for pol in $policies; do
        status=$(echo $pol | base64 --decode | jq ".status")
        if [ $status = "\"ACTIVE\"" ]; then
            system=$(echo $pol | base64 --decode | jq ".system")
            if [ $system = "false" ]; then
                id=$(echo $pol | base64 --decode | jq ".id")
                name=$(echo $pol | base64 --decode | jq ".name")
                desc=$(echo $pol | base64 --decode | jq ".description")
                priority=$(echo $pol | base64 --decode | jq ".priority")
                resource=$(clean "${name}")

                if [ $ptype = "OKTA_SIGN_ON" ]; then
                    echo "# ----  terraform import okta_policy_signon.$resource $id"
                    echo "resource \"okta_policy_signon\" \"$resource\" {"
                else
                    echo "# ----  terraform import okta_policy_mfa.$resource $id"
                    echo "resource \"okta_policy_mfa\" \"$resource\" {"
                fi
                echo "  name        = $name"
                echo "  description = $desc"
                echo "  priority    = $priority"

                group=$(echo $pol | base64 --decode | jq ".conditions.people.groups.include[0]" | tr -d '"')
                groupName=$(curl -s -X GET "$url/v1/groups/$group"  -H "Authorization: SSWS $okta_token" | jq ".profile.name")
                echo "  groups_included = [ data.okta_group.groups[$groupName].id ]"

                if [ $ptype = "MFA_ENROLL" ]; then
                    echo ""
                    settings=$(echo $pol | base64 --decode | jq ".settings.factors")
                    for sett in $(echo $settings | jq 'keys' | jq ".[]"); do
                        setting=$(echo $sett | tr -d '"')
                        echo "  $setting  = {"
                        enroll=$(echo $pol | base64 --decode | jq ".settings.factors.$setting.enroll.self")
                        echo "    enroll = $enroll"
                        consent=$(echo $pol | base64 --decode | jq ".settings.factors.$setting.consent.type")
                        if [ $consent != "\"NONE\"" ]; then
                            echo "    consent_type = $consent"
                        fi
                        echo "  }"
                        echo ""
                    done
                fi

                echo "}"
                echo ""
            fi
        fi
    done
done
