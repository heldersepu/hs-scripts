variable "platform" {
  type      = string
  sensitive = true
  default   = "gcp"
}

locals {
  template_file = templatefile(
    "./test.sh",
    { platform = var.platform }
  )
}

resource "local_file" "example" {
  filename = "./test.sh"
  content  = local.template_file
}

resource "null_resource" "setup_wiz_outpost_lite" {
  depends_on = [local_file.example]
  triggers = {
    runners = sha256(local.template_file)
  }
  provisioner "local-exec" {
    when    = create
    command = "echo create"
  }
}

output "file" {
  value     = local.template_file
  sensitive = true
}

output "content_sha256" {
  value = local_file.example.content_sha256
}

output "local_sha256" {
  value = nonsensitive(sha256(local.template_file))
}

output "filesha256" {
  value = filesha256("./test.sh")
}