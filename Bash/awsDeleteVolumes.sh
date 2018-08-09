RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color


if [ -z ${SWAPEX_ENVIRONMENT+x} ]  ; then
    echo "${RED}You need to set your SWAPEX_ENVIRONMENT variables${NC}" ;
else
    arr=($(aws ec2 describe-volumes --filters "Name=status,Values=available" | jq -r '.Volumes[].VolumeId'))

    min=0
    max=$(( ${#arr[@]} -1 ))

    while [[ min -lt max ]]
    do
        echo "${RED}${s} ${GRN} ${arr[$min]} ${NC}"
        echo "${RED}${s} ${GRN} ${arr[$max]} ${NC}"
        aws ec2 delete-volume --region us-east-1 --volume-id ${arr[$min]} &
        aws ec2 delete-volume --region us-east-1 --volume-id ${arr[$max]}
        echo ""
        (( min++, max-- ))
    done
fi
