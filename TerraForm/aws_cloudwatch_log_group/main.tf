provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

resource "aws_cloudwatch_log_group" "log_groups" {
  for_each = toset(["log-group1", "log-group2", "test-foo", "test-bar"])
  name     = each.value
}