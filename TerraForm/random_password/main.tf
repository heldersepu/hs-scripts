variable "my_service_names" {
  default = ["one", "two"]
}

resource "random_password" "pws" {
  for_each         = toset(var.my_service_names)
  length           = 19
  special          = true
  override_special = "_%@"
}

resource "null_resource" "test" {
  for_each = toset(var.my_service_names)

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "echo ${random_password.pws[each.key].result}"
  }
}