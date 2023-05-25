provider "aws" { region = "us-east-1" }

data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

data "aws_subnet" "x" {
  filter {
    name   = "tag:Name"
    values = ["test"]
  }
}

resource "aws_launch_template" "foo" {
  name          = "foo"
  image_id      = data.aws_ami_ids.ubuntu.ids[0]
  instance_type = "t2.micro"

  network_interfaces {
    subnet_id = data.aws_subnet.x.id
  }

  metadata_options {
    http_endpoint = "disabled"
    http_tokens   = "required"
  }

  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }
}