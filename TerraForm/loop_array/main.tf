locals {
  ingress = {
    443 : "tcp",
    22 : "tcp"
  }
}

resource "aws_security_group_rule" "in_tcp" {
  for_each          = local.ingress
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = each.value
  self              = true
  security_group_id = "sg-123456"
}