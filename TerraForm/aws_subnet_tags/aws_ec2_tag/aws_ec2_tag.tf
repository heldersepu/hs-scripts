variable "all_tags" {
  type = map(string)
}

variable "resource_id" {
  type = string
}

variable "resource_tags" {
  type = map(string)
}

locals {
  a        = [for k, v in var.all_tags : { "${k}" : v }]
  b        = [for k, v in var.resource_tags : { "${k}" : v }]
  subtract = setsubtract(local.a, local.b)
  tags     = { for k, v in var.resource_tags : k => v }
}

resource "aws_ec2_tag" "subnet_tags" {
  for_each = local.tags

  resource_id = var.resource_id
  key         = each.key
  value       = each.value
}
