provider "aws" {
   version = "~> 2.0"
   region  = "us-east-1"
}

resource "aws_transfer_server" "sftp" {
  identity_provider_type = "SERVICE_MANAGED"
}
