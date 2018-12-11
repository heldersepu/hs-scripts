resource "aws_instance" "amzn" {
  count                  = "${var.amzn_ec2_enabled}"
  ami                    = "${data.aws_ami.amzn.id}"
  instance_type          = "t2.nano"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Terraformed = "true"
    Name        = "amzn"
  }

  lifecycle {
    ignore_changes  = ["ami", "user_data"]
    prevent_destroy = false
  }
}
