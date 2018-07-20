resource "aws_instance" "win2016" {
  count                  = "${var.win_ec2_enabled}"
  ami                    = "${data.aws_ami.win2016.id}"
  instance_type          = "m5.large"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  ephemeral_block_device {
    virtual_name = "ephemeral0"
    device_name  = "xvde"
    no_device    = false
  }

  tags {
    Terraformed = "true"
    Name        = "win2016"
  }

  volume_tags {
    Terraformed = "true"
    Name        = "win2016 volume root"
  }
}

resource "aws_instance" "suse12" {
  count                  = "${var.ec2_enabled}"
  ami                    = "${data.aws_ami.suse12.id}"
  instance_type          = "m5d.large"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_type           = "gp2"
    volume_size           = "27"
    delete_on_termination = true
  }

  ephemeral_block_device {
    virtual_name = "ephemeral0"
    device_name  = "/dev/sde"
    no_device    = false
  }

  tags {
    Terraformed = "true"
    Name        = "suse12"
  }

  volume_tags {
    Terraformed = "true"
    Name        = "suse12 volume root"
  }

  lifecycle {
    ignore_changes  = ["ami", "user_data", "instance_type", "ebs_optimized", "volume_tags", "ebs_block_device"]
    prevent_destroy = false
  }
}
