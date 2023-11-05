terraform {
  required_providers {
    javascript = { source = "apparentlymart/javascript" }
  }
}

data "javascript" "MiXcAsE" {
  source = file("mixcase.js")
  vars = { input = "abcdefgh" }
}

output "result" {
  value = data.javascript.MiXcAsE.result
}