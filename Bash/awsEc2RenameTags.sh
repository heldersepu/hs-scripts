## Example:
#    In all instances where names Match "Test" replace the tags containing "Blue" with "Red"
#    . awsEc2RenameTags.sh Test Blue Red
#  

json=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=*${1}*" "Name=instance-state-name,Values=running")

arrids=($(echo $json | jq  -r ".Reservations[].Instances[].InstanceId"))
for id in "${arrids[@]}"; do
    echo "- $id"
    instance=$(echo $json | jq -r ".Reservations[].Instances[] | select(.InstanceId == \"$id\" )")
    arrtags=($(echo $instance | jq -c '.Tags[]'))
    for tag in "${arrtags[@]}"; do
        if [[ $tag == *"${2}"* ]]; then
            echo "  - $tag"
            aws ec2 delete-tags --resources $id --tags $tag  
            aws ec2 create-tags --resources $id --tags ${tag//$2/$3}
        fi
    done
done
