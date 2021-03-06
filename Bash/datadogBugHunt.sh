cd ~/.go/src/github.com/terraform-providers/terraform-provider-datadog/
#ff676b524133b0e1a8ecbafa2a88aa5774eb5b56
git checkout 11c6e0071372241431e76f5edd83f6bcd5d3bcb5
make build

mv ~/.go/bin/terraform-provider-datadog ~/.terraform.d/plugins/linux_amd64/terraform-provider-datadog

cd ~/code/hs-scripts/TerraForm/datadog/
terraform init >/dev/null 2>&1
export TF_LOG=TRACE; terraform apply -auto-approve
export TF_LOG=;terraform destroy -auto-approve >/dev/null 2>&1
