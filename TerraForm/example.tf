provider "aws" {
  region = "us-east-1"
}

module "bucket11" {
  source  = "environment"
  enabled = 0
}

resource "aws_s3_bucket" "sample_bucket12629" {
  count  = "${var.enabled * var.buckets}"
  bucket = "my-tf-test-bucket12629"
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_ebs_volume" "data" {
  count             = "1"
  availability_zone = "us-east-1a"
  size              = "5"
}

resource "aws_key_pair" "sshkey" {
  count      = "${var.ec2_enabled}"
  key_name   = "sshkey"
  public_key = "${var.sshkey}"
}
