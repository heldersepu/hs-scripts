variable "objects" {
  default = 9
}

variable "items" {
  default = ["red", "blue", "cyan"]
}

locals {
  distrib = [for i in range(var.objects) : element(var.items, (i % length(var.items)))]
}

resource "random_shuffle" "random" {
  input        = local.distrib
  result_count = var.objects
}

output "test" {
  value = random_shuffle.random.result
}