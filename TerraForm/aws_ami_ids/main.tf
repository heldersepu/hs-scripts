provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*18*"]
  }
}

resource "null_resource" "test" {
  count = length(data.aws_ami_ids.ubuntu.ids)
  triggers = {
    id = count.index
  }
}