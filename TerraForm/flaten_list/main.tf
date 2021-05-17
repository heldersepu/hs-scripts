variable "host_name" {
  type    = map(number)
  default = {
    "Manager" = 1
    "Worker" = 2
  }
}

locals {
  expanded_names = jsonencode({
    for name, count in var.host_name : name => [
      for i in range(count) : format("%s-%02d", name, i+1)
    ]
  })
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami           = "ami-1c761163"
  instance_type = "r5.large"

  tags = {
    Terraformed = "true"
    Name        = local.expanded_names
  }
}
