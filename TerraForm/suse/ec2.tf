provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "suse12" {
  filter {
    name   = "image-id"
    values = ["ami-1c761163"]
  }
}

resource "aws_instance" "suse12" {
  ami               = data.aws_ami.suse12.id
  instance_type     = "m5d.large"
  availability_zone = "us-east-1a"

  volume_tags {
    Name = "suse12 volume tags"
  }
}

resource "aws_ebs_volume" "data-ndj" {
  type              = "gp2"
  size              = 110
  availability_zone = "us-east-1a"

  tags {
    Name = "suse12-data-ndj"
  }
}

resource "aws_volume_attachment" "data-ndj" {
  device_name = "/dev/sdj"
  instance_id = aws_instance.suse12.*.id[0]
  volume_id   = aws_ebs_volume.data-ndj.*.id[0]
}
