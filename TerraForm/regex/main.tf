variable "region" {
    default = "us-west-2"
}

locals {
    abbreviated = join("", regex("(.*)-([[:alpha:]]).*-(.*)", var.region))
}


output "test" {
    value = local.abbreviated
}