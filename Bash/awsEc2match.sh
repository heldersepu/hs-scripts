
declare -a arr=(
    "-hana-"
    "-app-"
    "-scs-"
    )

RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

for i in "${arr[@]}"
do
    echo "${GRN} ${i} ${NC}"
    aws ec2 describe-instances --filters "Name=tag:Name,Values=*${i}*" | jq -r '.Reservations[].Instances[].PrivateIpAddress'
    echo ""
done
