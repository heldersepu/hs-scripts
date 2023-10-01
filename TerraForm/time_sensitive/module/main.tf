variable "data" {
  description = "input"
}

resource "null_resource" "sh_test" {
  provisioner "local-exec" {
    when        = create
    command     = "echo '${var.data.version}'"
    interpreter = ["/bin/sh", "-c"]
  }
}

output "data" {
  value = var.data
}