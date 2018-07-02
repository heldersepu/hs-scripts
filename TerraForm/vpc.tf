resource "aws_vpc" "myvpc" {
  count                = "${var.vpc_enabled}"
  cidr_block           = "${var.cidr}"
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
  count                   = "${var.vpc_enabled}"
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "${aws_vpc.myvpc.cidr_block}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = false
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.myvpc.default_network_acl_id}"

  tags {
    Name = "default_network_acl"
  }
}
