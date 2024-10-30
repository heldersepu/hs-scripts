locals {
  data = yamldecode(file("bad.yaml"))
}

output "bad_data" {
  value = local.data
}