provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

variable "vpc_id" {
  default = "vpc-0627130d668a04f24"
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

locals {
  combined_subnet_tags = merge(values(data.aws_subnet.subnet)[*].tags...)
}

module "aws_ec2_tags" {
  for_each = data.aws_subnet.subnet
  source   = "./aws_ec2_tag"

  all_tags      = local.combined_subnet_tags
  resource_id   = each.key
  resource_tags = each.value.tags
}
