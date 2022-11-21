locals {
  sg = {
    egress = {
      53 : "udp"
      123 : "udp"
    }
    ingress = {
      443 : "tcp",
      22 : "tcp"
    }
  }
}

module "security_group_rules" {
  for_each          = local.sg
  source            = "./sg_rule"
  sg_type           = each.key
  sg_data           = each.value
  security_group_id = "sg-123456"
}