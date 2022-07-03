RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

declare -a sizes=("1024" "600" "500" "300" "200" "60" "50" "20" "10" "1")

if [ -z ${SWAPEX_ENVIRONMENT+x} ]  ; then
    echo "${RED}You need to set your SWAPEX_ENVIRONMENT variables${NC}" ;
else
    for s in "${sizes[@]}"
    do
        arr=($(aws ec2 describe-snapshots --owner-ids 998877665544 --filters Name=volume-size,Values=${s} | jq -r '.Snapshots[].SnapshotId'))

        min=0
        max=$(( ${#arr[@]} -1 ))

        while [[ min -lt max ]]
        do
            echo "${RED}${s} ${GRN} ${arr[$min]} ${NC}"
            echo "${RED}${s} ${GRN} ${arr[$max]} ${NC}"
            aws ec2 delete-snapshot --region us-east-1 --snapshot-id ${arr[$min]} &
            aws ec2 delete-snapshot --region us-east-1 --snapshot-id ${arr[$max]}
            echo ""
            (( min++, max-- ))
        done
        echo " -- -- -- -- -- -- -- -- -- -- -- -- -- "
    done
fi
