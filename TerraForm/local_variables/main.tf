variable "a" { default = "aaa" }
variable "b" { default = "bbb" }

locals {
  pools = { (var.a) = var.b }
}

output "test" {
  value = local.pools
}
