provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

variable "security_groups" {}

data "aws_vpc" "v" {
  id = "vpc-0627130d668a04f24"
}

locals {
  vpc_id = {
    tersu = data.aws_vpc.v
  }
  all_rules = [
    [
      for sg in var.security_groups : [
        for i, ingress in sg.ingress :
          merge({ "name" : sg.name, "type" : "ingress", "index" : i }, ingress)
      ]
    ],
    [
      for index, sg in var.security_groups : [
        for i, egress in sg.egress :
          merge({ "name" : sg.name, "type" : "egress", "index" : i }, egress)
      ]
    ]
  ]
  rules = {
    for x in flatten(local.all_rules) : "${x.name}_${x.type}_${x.index}" => x
  }
}

resource "aws_security_group" "sg" {
  for_each = var.security_groups
  name     = each.value.name
  vpc_id   = local.vpc_id[each.value.vpc].id
}

resource "aws_security_group_rule" "rule" {
  for_each          = local.rules
  security_group_id = aws_security_group.sg[each.value.name].id

  type        = each.value.type
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = lookup(each.value, "cidr_blocks", null)

  source_security_group_id = lookup(each.value, "security_groups", null) == null ? null : (
    aws_security_group.sg[each.value.security_groups].id
  )
}
