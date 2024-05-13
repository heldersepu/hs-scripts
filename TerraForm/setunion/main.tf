variable "stages" {
  default = []
}

locals {
  accounts = {
    dev = [1, 2, 3, 4]
    stg = [4, 5, 6, 7]
    prd = [7, 8, 9, 0]
  }
}

output "test1" {
  value = setunion(local.accounts["dev"], local.accounts["stg"])
}

output "test2" {
  value = toset(flatten([
    for a in var.stages : local.accounts[a]
  ]))
}