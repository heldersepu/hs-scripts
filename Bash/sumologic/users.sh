roles=$(curl -u "$sumo_key" -X GET https://api.us2.sumologic.com/api/v1/roles | jq -r ".data[] | @base64")
users=$(curl -u "$sumo_key" -X GET https://api.us2.sumologic.com/api/v1/users | jq -r ".data[] | @base64")

for user in $users; do
    id=$(echo $user | base64 --decode | jq -r ".id")
    fname=$(echo $user | base64 --decode | jq -r ".firstName")
    lname=$(echo $user | base64 --decode | jq -r ".lastName")
    email=$(echo $user | base64 --decode | jq -r ".email")
    active=$(echo $user | base64 --decode | jq -r ".isActive")
    roleIds=$(echo $user | base64 --decode | jq ".roleIds")

    resource=$(echo $email | tr '[:upper:]' '[:lower:]')
    resource="${resource// /_}"
    resource="${resource/./_}"
    resource="${resource/@/_}"

    echo "# ----  terraform import sumologic_user.$resource $id"

    echo "resource \"sumologic_user\" \"$resource\" {"
    echo "  first_name  = \"$fname\""
    echo "  last_name   = \"$lname\""
    echo "  email       = \"$email\""
    echo "  active      = $active"
    echo ""
    echo "  role_ids   = []"
    echo "}"

    echo ""
done