locals {
  subnets = {
    100 = {
      cidr_block = "10.0.208.0/20"
      tags       = {}
    },
    200 = {
      cidr_block = "10.0.192.0/20"
      tags       = {Name = "GOOD"}
    },
    500 = {
      cidr_block = "10.0.224.0/20"
      tags       = {Name = "BAD", Type = "SLOW"}
    },
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
  cidr_block = each.value.cidr_block
  tags       = each.value.tags    
}

