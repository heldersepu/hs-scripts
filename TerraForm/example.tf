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
