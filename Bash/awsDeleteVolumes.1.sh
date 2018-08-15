RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color


if [ -z ${SWAPEX_ENVIRONMENT+x} ]  ; then
    echo "${RED}You need to set your SWAPEX_ENVIRONMENT variables${NC}" ;
else
    declare -a arr=(
        "vol-00245c08b29c5d3dd"
        "vol-003f97d7daf1542c0"
        "vol-005e9d3299114fa42"
        "vol-0069f6727f36002e8"
        "vol-006bd7130f785802a"
    )

    for i in "${arr[@]}"
    do
        echo "${GRN} ${i} ${NC}"
        aws ec2 detach-volume --region us-east-1 --volume-id ${i}
    done

    for i in "${arr[@]}"
    do
        echo "${GRN} ${i} ${NC}"
        aws ec2 delete-volume --region us-east-1 --volume-id ${i}
    done
fi
