provider "aws" { region = "us-east-2" }

locals {
  allowed_os = {
    "amazon" : { owner : "amazon", filter : "amzn2-ami-hvm*" },
    "suse" : { owner : "amazon", filter : "*suse*" },
    "RHEL" : { owner : "amazon", filter : "*RHEL*" },
    "ubuntu" : { owner : "099720109477", filter : "*ubuntu-bionic-18.04-amd64-*" },
  }
}

variable "ami_name" {
  default = "ubuntu"

  validation {
    condition     = can(regex("amazon|suse|RHEL|ubuntu", var.ami_name))
    error_message = "Invalid ami name, allowed_values = [amazon suse RHEL ubuntu]."
  }
}

data "aws_ami" "os" {
  for_each = local.allowed_os

  most_recent = true
  owners      = [each.value.owner]
  filter {
    name   = "name"
    values = [each.value.filter]
  }
}

resource "aws_instance" "linux" {
  ami           = data.aws_ami.os[var.ami_name].id
  instance_type = "t2.micro"
  # ... todo add arguments here
}