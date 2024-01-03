variable "objects" {
  default = 12
}

locals {
    distrib = [ for i in range(var.objects) : (i % 3) + 1 ]
}

resource "random_shuffle" "random" {
  input        = local.distrib
  result_count = var.objects
}

output "test" {
    value = random_shuffle.random.result
}