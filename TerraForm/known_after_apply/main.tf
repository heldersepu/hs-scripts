variable "input" {
    default = {}
}

resource "random_string" "key" {
  length  = 32
  special = false
}

locals {
  platform = {
    x = {
      abc = try(var.input.run, false) ? random_string.key.result : "",
      def = random_string.key.result
    }
  }
}

output "test" {
  value = local.platform
}
