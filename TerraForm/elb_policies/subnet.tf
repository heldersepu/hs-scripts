resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.2.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "app" {
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "${aws_vpc.myvpc.cidr_block}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.myvpc.id}"
}