terraform {
  experiments = [variable_validation]
}

variable "image_id" {
  type = string

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "data" {
  default = ["bla", "foo"]
}

resource "null_resource" "data" {
  for_each = toset(var.data)

  provisioner "local-exec" {
    when    = "create"
    command = "echo ${each.value};"
  }
}

output "data" {
  value = null_resource.data
}

output "myout" {
  value = [for v in null_resource.data : v.id]
}

output "myout2" {
  value = { for k, v in null_resource.data : k => v.id }
}
