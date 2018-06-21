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
