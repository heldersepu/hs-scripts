provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "default" {
  bucket = "testbeanstack"
}

resource "aws_s3_bucket_object" "default" {
  bucket = aws_s3_bucket.default.id
  key    = "beanstalk/Node.zip"
  source = "Node.zip"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = "tf-test-name"
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.default.id
  key         = aws_s3_bucket_object.default.id
}

resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "tf-test-name"
  description = "tf-test-name"
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  description            = "test"
  application            = aws_elastic_beanstalk_application.tftest.name
  name                   = "synchronicity-dev"
  cname_prefix           = "ops-api-opstest"
  solution_stack_name    = "64bit Amazon Linux 2 v5.0.1 running Node.js 12"
  tier                   = "WebServer"
  wait_for_ready_timeout = "20m"
}
