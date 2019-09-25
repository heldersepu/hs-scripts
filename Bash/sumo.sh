roles=$(curl -u "$sumo_key" -X GET https://api.us2.sumologic.com/api/v1/roles | jq -r ".data[] | @base64")
for role in $roles; do
    id=$(echo $role | base64 --decode | jq -r ".id")
    name=$(echo $role | base64 --decode | jq -r ".name")
    desc=$(echo $role | base64 --decode | jq -r ".description")
    system=$(echo $role | base64 --decode | jq -r ".systemDefined")
    filter=$(echo $role | base64 --decode | jq ".filterPredicate")


    resource=$(echo $name | tr '[:upper:]' '[:lower:]')
    resource="${resource// /_}"
    resource="${resource/(/_}"
    resource="${resource/)/_}"

    echo "# ----  terraform import sumologic_role.$resource $id"

    echo "resource \"sumologic_role\" \"$resource\" {"
    echo "  name        = \"$name\""
    echo "  description = \"$desc\""
    echo ""
    echo "  filter_predicate = $filter"
    if [ $system = "false" ]; then
        echo "  capabilities     = []"
    fi
    echo ""
    echo "  lifecycle {"
    if [ $system = "false" ]; then
        echo "    ignore_changes = [\"users\"]"
    else
        echo "    ignore_changes = [\"users\", \"capabilities\"]"
    fi
    echo "  }"
    echo "}"

    echo ""
done