provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

variable "vpcs" {
  type = map(any)
  default = {
    a = { x = 1 }
    b = { x = 2 }
  }
}

variable "instances" {
  type = map(any)
  default = {
    x = { vpc = "a" }
    y = { vpc = "b" }
    z = { vpc = "a" }
  }
}

module "vpc" {
  for_each = var.vpcs
  source   = "git::https://github.com/gruntwork-io/terraform-fake-modules.git//modules/aws/vpc?ref=main"
}

module "eks" {
  for_each = var.instances
  source   = "git::https://github.com/gruntwork-io/terraform-fake-modules.git//modules/aws/eks?ref=main"
  vpc_id   = module.vpc[each.value.vpc].id
}

output "test" {
  value = module.eks
}
