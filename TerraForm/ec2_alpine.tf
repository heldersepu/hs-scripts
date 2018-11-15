resource "aws_instance" "alpine" {
  count                  = "${var.alpine_ec2_enabled}"
  ami                    = "${data.aws_ami.alpine.id}"
  instance_type          = "m5d.large"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Terraformed = "true"
    Name        = "alpine"
  }

  lifecycle {
    ignore_changes  = ["ami", "user_data"]
    prevent_destroy = false
  }
}
