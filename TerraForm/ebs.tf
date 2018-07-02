resource "aws_ebs_volume" "data-ndj" {
  count             = "${var.ec2_enabled}"
  type              = "gp2"
  size              = 200
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "suse12-data-ndj"
  }

  lifecycle {
    ignore_changes  = ["type"]
    prevent_destroy = false
  }
}

resource "aws_volume_attachment" "data-ndj" {
  count       = "${var.ec2_enabled}"
  device_name = "/dev/sdj"
  instance_id = "${aws_instance.suse12.*.id[0]}"
  volume_id   = "${aws_ebs_volume.data-ndj.*.id[0]}"
}
