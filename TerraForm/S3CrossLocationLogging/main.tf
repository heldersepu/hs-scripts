provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "eu"
  region = "eu-west-2"
}

resource "aws_s3_bucket" "main" {
  bucket = "bucket-test1239-main"
}

resource "aws_s3_bucket" "log" {
  provider = aws.eu
  bucket   = "bucket-test1239-logs"
}

resource "aws_s3_bucket_logging" "log" {
  provider = aws.eu
  bucket   = aws_s3_bucket.main.id

  target_bucket = aws_s3_bucket.log.id
  target_prefix = "log/"
}