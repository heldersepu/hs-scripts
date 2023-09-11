variable "repository" {
  type = string
}

variable "environment" {
  type = string
}

variable "variables" {
  type = map(string)
}

resource "null_resource" "sh_test" {
  for_each = var.variables
  provisioner "local-exec" {
    when        = create
    command     = "echo '${each.value}' "
    interpreter = ["/bin/sh", "-c"]
  }
}
