resource "aws_efs_file_system" "efs" {
  count = 0
  creation_token = "aws_efs_file_system"
}

resource "aws_efs_mount_target" "data" {
  count = 0
  file_system_id  = "${aws_efs_file_system.efs.id}"
  subnet_id       = "${aws_subnet.app1.id}"
  #security_groups = ["${aws_security_group.allow_all.id}"]
}