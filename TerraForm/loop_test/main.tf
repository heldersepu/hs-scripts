provider "aws" {
  region = "us-west-1"
}

variable "data" {
  type = list(object({
    name = string
    test = string
  }))

  default = [ {name:"foo", test:"1"}, {name:"bar", test:"2"} ]
}

locals {
    data = { for x in var.data : join("_", [x.name, x.test]) => x }
}

data "template_file" "test" {
  for_each = local.data
  template = ""
}

output "out" {
    value = data.template_file.test
}