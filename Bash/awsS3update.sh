# Script to update file in S3
function updateTfvars() {
    key=$(echo $1 | sed 's/=.*//')
    sed -i.bk "s/$key=.*//g" terraform.tfvars
    echo $1 >> "terraform.tfvars"
}


bucket=$(aws s3api list-buckets  | jq -r '.Buckets[] | select(.Name|test("secrets-."))'.Name)
env="${bucket/secrets-/}"
rm "terraform.tfvars"
aws s3 cp "s3://$bucket/terraform/strategy/$env/terraform.tfvars" "terraform.tfvars"
backup="terraform.tfvars.$(date '+%Y_%m_%d-%H-%M').bak"
cp terraform.tfvars $backup

updateTfvars 'key1 = "value1"'
updateTfvars 'key2 = "value2"'

aws s3 cp "terraform.tfvars" "s3://$bucket/terraform/strategy/$env/terraform.tfvars"
aws s3 cp "$backup" "s3://$bucket/terraform/strategy/$env/$backup"

