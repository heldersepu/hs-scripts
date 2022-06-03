provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "suse12" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*suse*"]
  }
}

locals {
  instances = toset(["one", "two"])
}

resource "aws_instance" "suse12" {
  for_each          = local.instances
  ami               = data.aws_ami.suse12.id
  instance_type     = "m5d.large"
  availability_zone = "us-east-1a"
  tags              = { Name = each.value }
}

resource "aws_ebs_volume" "data-ndj" {
  for_each          = local.instances
  type              = "gp2"
  size              = 110
  availability_zone = "us-east-1a"

}

resource "aws_volume_attachment" "data-ndj" {
  for_each    = local.instances
  device_name = "/dev/sdj"
  instance_id = aws_instance.suse12[each.key].id
  volume_id   = aws_ebs_volume.data-ndj[each.key].id
}
