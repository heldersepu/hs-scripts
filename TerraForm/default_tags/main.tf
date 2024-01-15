provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
  default_tags {
    tags = {
      foo = "Test"
      bar = "abc"
      bas = "abd"
      bat = "abe"
    }
  }
}

data "aws_default_tags" "example" {}

locals {
  data = jsonencode({ for k, v in data.aws_default_tags.example : k => v })
}

output "data" {
  value = local.data
}
output "data1" {
  value = sha1(local.data)
}
