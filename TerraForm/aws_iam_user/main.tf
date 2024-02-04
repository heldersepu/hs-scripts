provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

resource "aws_iam_user" "test" {
  name = "test123"
  tags = {
    foo = "bar"
  }

  lifecycle {
    ignore_changes = [tags["adf"]]
  }
}