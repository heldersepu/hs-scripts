provider "aws" {
  region = "us-west-1"
  alias  = "r1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "r2"
}


locals {
  cidrs = [
    "10.0.2.0/24",
    "10.1.2.0/24",
    "10.2.2.0/24",
  ]
}

resource "aws_vpc" "test_vpc" {
  count = length(local.cidrs)
  //depends_on = [aws_vpc.test_vpc[count.index-1]]

  provider   = aws.r1
  cidr_block = local.cidrs[count.index]

  tags = {
    Name = "test_vpc"
  }
}
