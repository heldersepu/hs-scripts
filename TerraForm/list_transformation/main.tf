variable "selected_vpc" {
  default = "vpc_name1"
}

locals {
  azs = {
    "vpc_name1" = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
    "vpc_name2" = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  }
  private_subnets = {
    "vpc_name1" = ["subnet-a", "subnet-b", "subnet-c"]
    "vpc_name2" = ["subnet-d", "subnet-e", "subnet-f"]
  }
}

output "test" {
  value = {
    for i, x in local.azs[var.selected_vpc] :
    (x) => { "id" : local.private_subnets[var.selected_vpc][i] }
  }
}