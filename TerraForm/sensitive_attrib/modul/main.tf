variable "data" {
  sensitive = true
}

locals {
  foo = {
    "data": var.data
    "foo": "bar"
  }
}

resource "terraform_data" "test" {
  triggers_replace = var.data
  provisioner "local-exec" {
    when = create
    command = "echo ${var.data}"
  }
}