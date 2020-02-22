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

variable "instance_type" {
  type = string

  validation {
    condition     = can(regex("t2.micro|m1.small|m1.large", var.instance_type))
    error_message = "Invalid instance type allowed_values = ['t2.micro', 'm1.small', 'm1.large']."
  }
}

variable "data" {
  default = {
    1 = {
      name = "bla"
      type = 1
    }
    2 = {
      name = "foo"
      type = 2
    }
  }
}

resource "null_resource" "data" {
  for_each = var.data

  provisioner "local-exec" {
    when    = create
    command = "echo ${each.value.name};"
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
