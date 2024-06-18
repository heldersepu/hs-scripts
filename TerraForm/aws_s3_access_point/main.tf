provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "example" {
  bucket = "example-${data.aws_caller_identity.current.account_id}"
}

# resource "aws_s3_access_point" "example" {
#   bucket = aws_s3_bucket.example.id
#   name   = "example"
# }

resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "aws s3control create-access-point --account-id ${data.aws_caller_identity.current.account_id} --bucket \"${aws_s3_bucket.example.id}\" --name \"test-123\""
  }
}