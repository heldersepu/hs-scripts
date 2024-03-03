data "local_file" "data" {
  filename = "${path.module}/data.json"
}

locals {
  region = jsondecode(data.local_file.data.content).region
}

provider "aws" {
  region                   = local.region
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

data "aws_region" "current" {}

output "region" {
  value = data.aws_region.current.name
}