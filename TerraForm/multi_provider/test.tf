provider "aws" {
    region = "us-west-1"
    alias  = "r1"
}

provider "aws" {
    region = "us-west-2"
    alias  = "r2"
}

resource "aws_vpc" "test_vpc" {
    provider   = "aws.r1"
    cidr_block = "10.0.2.0/24"

    tags { 
        Name = "test_vpc" 
    }
}