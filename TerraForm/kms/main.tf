provider "aws" {
  region = "us-east-1"
}

resource "aws_kms_key" "key" {
  description             = "This is a test key"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "alias" {
  name          = "alias/testkey"
  target_key_id = aws_kms_key.key.key_id
}
