variable "groupsetuparray" {
  type = any
  default = [{
    name        = "DFDeveloperTeam",
    group_roles = ["DataFactoryContributor", "SQLServerContributor"]
  }]
}

locals {
  group_roles = flatten([
    for group in var.groupsetuparray : [
      for role in group.group_roles : {
        name = group.name
        role = role
      }
    ]
  ])
}

data "local_file" "input" {
  for_each = toset(["DataFactoryContributor", "SQLServerContributor"])
  filename = "${path.module}/${each.value}.txt"
}

resource "null_resource" "test" {
  for_each = {
    for group in local.group_roles :
    "${group.name}-${group.role}" => group
  }
  triggers = {
    "key"     = each.key
    "role"    = each.value.role
    "content" = data.local_file.input[each.value.role].content
  }
}