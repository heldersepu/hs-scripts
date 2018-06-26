resource "aws_instance" "win2016" {
  count         = "${var.ec2_enabled}"
  ami           = "${data.aws_ami.win2016.id}"
  instance_type = "m5.large"
  key_name      = "${aws_key_pair.testkey.key_name}"

  tags {
    Terraformed = "true"
    Name        = "win2016"
  }
}

resource "aws_instance" "suse12" {
  count         = "${var.ec2_enabled}"
  ami           = "${data.aws_ami.suse12.id}"
  instance_type = "m5.xlarge"
  key_name      = "${aws_key_pair.testkey.key_name}"

  tags {
    Terraformed = "true"
    Name        = "suse12"
  }
}
