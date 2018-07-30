
declare -a arr=(
    "-app-"
    "-hana-"
    "-scs-"
    )

RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

for i in "${arr[@]}"
do
    echo "${GRN} ${i} ${NC}"
    json=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=*${i}*")
    arrids=($(echo $json | jq -r '.Reservations[].Instances[].InstanceId'))
    prvips=($(echo $json | jq -r '.Reservations[].Instances[].PrivateIpAddress'))
    echo ""
    for id in "${arrids[@]}"
    do
        echo "${RED} ${id} ${NC}"
        #aws ec2 start-instances --instance-ids ${id} | jq -r '.StartingInstances[].CurrentState.Name'
        #aws ec2 stop-instances --instance-ids ${id} | jq -r '.StoppingInstances[].CurrentState.Name'
        #echo ""
    done
done