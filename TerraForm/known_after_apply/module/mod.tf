variable "input_run" {
  type = bool
}

resource "random_string" "key" {
  length  = 32
  special = false
}

locals {
  platform = {
    x = {
      abc = var.input_run ? base64encode(random_string.key.result) : "",
      def = random_string.key.result
    }
  }
}

output "platform" {
  value = local.platform
}
