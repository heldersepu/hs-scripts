locals {
  subnets = {
    cow = "10.0.208.0/20",
    cat = "10.0.192.0/20",
    dog = "10.0.224.0/20"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.myvpc.id
  for_each   = local.subnets
  cidr_block = each.value
  tags       = { Name = each.key }
}

output "subnets" {
  value = aws_subnet.subnet
}

output "subnets_arn" {
  value = { for k, v in aws_subnet.subnet : k => v.arn }
}

