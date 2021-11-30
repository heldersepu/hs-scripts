locals {
  apps = ["app1", "app2", "app3", "app4"]
}

resource "null_resource" "set_initial_state" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = "echo \"0\" > counter"
  }
}

module "test" {
  for_each = { for k, v in local.apps : k => v }
  index    = each.key
  source   = "./module"
}


