variable "platform" {
  type    = string
  default = "gcp"
}

data "template_file" "init" {
  template = file("./test.sh")
  vars = {
    platform = var.platform
  }
}

output "file" {
  value = data.template_file.init.rendered
}