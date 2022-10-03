resource "aws_efs_file_system" "efs" {
  count            = var.efs_enabled
  creation_token   = "aws_efs_file_system"
  performance_mode = "maxIO"
}

resource "aws_efs_mount_target" "data" {
  count          = var.efs_enabled
  file_system_id = aws_efs_file_system.efs[0].id
  subnet_id      = aws_subnet.app1.id

  #security_groups = ["${aws_security_group.allow_all.id}"]
}
