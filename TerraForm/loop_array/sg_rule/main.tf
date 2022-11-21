variable "sg_data" {
  type = any
}

variable "sg_type" {
  type = string
}

variable "security_group_id" {
  type = string
}

resource "aws_security_group_rule" "sg" {
  for_each          = var.sg_data
  type              = var.sg_type
  from_port         = each.key
  to_port           = each.key
  protocol          = each.value
  self              = true
  security_group_id = var.security_group_id
}