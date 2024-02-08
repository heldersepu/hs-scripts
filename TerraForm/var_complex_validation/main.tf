variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Only dev stage or prod allowed"
  }
}

variable "instance_type" {
  type = string

  validation {
    condition     = startswith(var.instance_type, "t2.")
    error_message = "Only t2 instance types allowed"
  }
}

output "validation" {
  value = "Environment ${var.environment} and instance ${var.instance_type}"
  precondition {
    condition     = !(var.environment == "dev" && strcontains(var.instance_type, "large"))
    error_message = "Large instances are not allowed in dev"
  }
}