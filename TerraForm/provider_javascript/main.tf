terraform {
  required_providers {
    javascript = { source = "apparentlymart/javascript" }
  }
}

data "javascript" "MiXcAsE" {
  for_each = fileset("${path.module}/..", "**")
  source = file("mixcase.js")
  vars = { input = each.key }
}

output "result" {
  value = [for x in data.javascript.MiXcAsE : x.result]
}
