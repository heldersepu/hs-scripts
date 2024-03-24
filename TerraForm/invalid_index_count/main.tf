provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

module "vpc" {
  count  = 0
  source = "git::https://github.com/gruntwork-io/terraform-fake-modules.git//modules/aws/vpc?ref=main"
}

output "vpc_id" {
  value = try(module.vpc[0].id, "")
}