terraform {
  required_providers {
    javascript = { source = "apparentlymart/javascript" }
  }
}

locals {
  files = fileset("${path.module}/..", "**")
  parent_folders = toset([
    for x in local.files: split("/", x)[0]
    if strcontains(x, "/") && !startswith(x, ".")
  ])
}

data "javascript" "MiXcAsE" {
  for_each = local.files
  source = file("mixcase.js")
  vars = { input = each.key }
}

output "result" {
  value = [for x in data.javascript.MiXcAsE : x.result]
}


output "parent_folders" {
  value = local.parent_folders
}
