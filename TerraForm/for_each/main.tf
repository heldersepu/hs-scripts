variable "list" {
  default = ["a", "b", "c"]
}

resource "null_resource" "test" {
  for_each = toset(var.list)

  provisioner "local-exec" {
    when        = "create"
    command     = "echo ${each.key} ${each.value};"
    interpreter = ["/bin/sh", "-c"]
  }
}
