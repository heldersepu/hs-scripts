
declare -a arr=(
    "arn:aws:cloudtrail:us-west-1:123456789123:trail/ct-dev-us-west-1"
    "arn:aws:cloudtrail:us-west-2:123456789123:trail/ct-dev-us-west-2"
    "arn:aws:cloudtrail:sa-east-1:123456789123:trail/ct-dev-sa-east-1"
    "arn:aws:cloudtrail:us-east-2:123456789123:trail/ct-dev-us-east-2"
    "arn:aws:cloudtrail:ca-central-1:123456789123:trail/ct-dev-ca-central-1"
    "arn:aws:cloudtrail:eu-west-2:123456789123:trail/ct-dev-eu-west-2"
    "arn:aws:cloudtrail:ap-northeast-2:123456789123:trail/ct-dev-ap-northeast-2"
    "arn:aws:cloudtrail:eu-west-1:123456789123:trail/ct-dev-eu-west-1"
    "arn:aws:cloudtrail:ap-northeast-1:123456789123:trail/ct-dev-ap-northeast-1"
    "arn:aws:cloudtrail:us-east-1:123456789123:trail/ct-dev-us-east-1"
    "arn:aws:cloudtrail:ap-south-1:123456789123:trail/ct-dev-ap-south-1"
    "arn:aws:cloudtrail:ap-southeast-2:123456789123:trail/ct-dev-ap-southeast-2"
    "arn:aws:cloudtrail:ap-southeast-1:123456789123:trail/ct-dev-ap-southeast-1"
    "arn:aws:cloudtrail:eu-central-1:123456789123:trail/ct-dev-eu-central-1"
    )

RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

if [ -z ${SWAPEX_ENVIRONMENT+x} ]  ; then 
    echo "${RED}You need to set your SWAPEX_ENVIRONMENT variables${NC}" ; 
else 
    TREGION={$AWS_REGION}
    for i in "${arr[@]}"
    do
        #Change the region on env variable
        REGION=${i//arn:aws:cloudtrail:/} 
        REGION=${REGION//:9966*/} 
        AWS_REGION=${REGION}

        echo "${GRN} ${i} ${NC}"
        aws cloudtrail delete-trail --region ${REGION} --name ${i}
        echo ""
    done
    AWS_REGION={$TREGION}
fi
