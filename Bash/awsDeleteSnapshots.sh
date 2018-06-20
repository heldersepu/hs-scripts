RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

declare -a sizes=("600" "300" "200" "60" "50" "20")

if [ -z ${SWAPEX_ENVIRONMENT+x} ]  ; then
    echo "${RED}You need to set your SWAPEX_ENVIRONMENT variables${NC}" ;
else
    for s in "${sizes[@]}"
    do
        arr=($(aws ec2 describe-snapshots --filters Name=volume-size,Values=${s} | jq -r '.Snapshots[].SnapshotId'))
        for i in "${arr[@]}"
        do
            if [ ${#i} -gt 15 ] ; then
                echo "${RED}${s} ${GRN} ${i} ${NC}"
                aws ec2 delete-snapshot --region us-east-1 --snapshot-id ${i}
                echo ""
            fi
        done
        echo " -- -- -- -- -- -- -- -- -- -- -- -- -- "
    done
fi
