sumo_key="id:key"
base_url="https://api.us2.sumologic.com/api/v1/accessKeys"
accessKeys=$(curl -u "$sumo_key" -X GET $base_url?limit=500 | jq -r ".data[] | @base64")

for key in $accessKeys; do
    id=$(echo $key | base64 --decode | jq -r ".id")
    label=$(echo $key | base64 --decode | jq -r ".label")
    echo $id  $label
    if [ "$label" = "DELETE ME" ]; then
        curl -u "$sumo_key" -X DELETE $base_url/$id
    fi
done
