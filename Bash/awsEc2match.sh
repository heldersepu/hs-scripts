
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
    # https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html#options
    # ( pending | running | shutting-down | terminated | stopping | stopped )
    json=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=*${i}*" "Name=instance-state-name,Values=running")
    arrids=($(echo $json | jq -r '.Reservations[].Instances[].InstanceId'))
    prvips=($(echo $json | jq -r '.Reservations[].Instances[].PrivateIpAddress'))
    echo ""
    for id in "${prvips[@]}"
    do
        echo "${RED}${id}${NC}"
        #aws ec2 start-instances --instance-ids ${id} | jq -r '.StartingInstances[].CurrentState.Name'
        #aws ec2 stop-instances --instance-ids ${id} | jq -r '.StoppingInstances[].CurrentState.Name'
        #echo ""
    done
done