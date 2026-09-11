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

output "file" {
  value     = local.template_file
  sensitive = true
}