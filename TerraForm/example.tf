provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "sample_bucket12629" {
  bucket = "my-tf-test-bucket12629"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.128.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false

  tags {
    Name = "aws_vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "app1" {
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "${cidrsubnet("10.0.128.0/24",2,0)}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = false
}

output "aws_availability_zones_names" {
  value = "${data.aws_availability_zones.available.names}"
}

output "aws_s3_bucket_name" {
  value = "${aws_s3_bucket.sample_bucket12629.id}"
}

output "aws_subnet_cidr_block" {
  value = "${aws_subnet.app1.cidr_block}"
}

output "aws_subnet_name" {
  value = "${aws_subnet.app1.id}"
}

output "aws_vpc_cidr_block" {
  value = "${aws_vpc.myvpc.cidr_block}"
}

output "aws_vpc_name" {
  value = "${aws_vpc.myvpc.id}"
}
