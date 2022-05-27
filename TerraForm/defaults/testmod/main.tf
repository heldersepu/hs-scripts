terraform {
  experiments = [module_variable_optional_attrs]
}

variable "network_acls" {
  description = ""
  type = map(object({
    direction = string
    access    = optional(string)
    protocol  = optional(string)
  }))
}

locals {
  network_acls = defaults(var.network_acls, {
    access   = "Deny"
    protocol = "*"
  })
}

resource "null_resource" "cluster" {
  for_each = local.network_acls
  triggers = {
    key       = each.key
    direction = each.value.direction
    access    = each.value.access
    protocol  = each.value.protocol
  }

  provisioner "local-exec" {
    command = "echo ${each.key}"
  }
}
