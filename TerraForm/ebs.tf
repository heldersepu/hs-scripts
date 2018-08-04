resource "aws_ebs_volume" "datav" {
  count             = "${var.ec2_add_volume}"
  type              = "gp2"
  size              = "${110 + count.index}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name  = "suse12-data"
    Count = "${count.index}"
  }

  lifecycle {
    ignore_changes  = ["type"]
    prevent_destroy = false
  }
}

resource "aws_volume_attachment" "datav" {
  count       = "${var.ec2_add_volume}"
  device_name = "${var.device_names[count.index]}"
  instance_id = "${aws_instance.suse12.*.id[0]}"
  volume_id   = "${aws_ebs_volume.datav.*.id[count.index]}"
}
