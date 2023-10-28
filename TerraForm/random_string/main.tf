resource "random_string" "key" {
  length  = 32
  special = false
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = <<EOT
        echo "${random_string.key.result}"
    EOT
  }
}