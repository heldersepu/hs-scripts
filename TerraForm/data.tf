data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "suse12" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse*12-*"]
  }

  filter {
    name   = "image-id"
    values = ["ami-3c062943"] #["ami-1c761163"] #["ami-2a497955"] #["ami-388f9642"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami" "win2016" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-2018.06.13*"]
  }

  filter {
    name   = "image-id"
    values = ["ami-0327667c"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
