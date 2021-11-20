locals {
  hour = formatdate("YYYYMMDDhh", timestamp())
}

resource "null_resource" "test" {
  triggers = {
    hour = local.hour
  }
  provisioner "local-exec" {
    command = "echo 'test'"
  }
}