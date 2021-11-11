variable "prod" {
  default = <<EOF
{
"subscription": "xxxxxx",
"tshirt_size": "large",
"env_prefix": "prod"
}
EOF
}

variable "global" {
  default = <<EOF
{
  "tshirtsizes": {
    "small": { "cpucount": 1 },
    "medium": { "cpucount": 2 },
    "large": { "cpucount": 3 }
  }
}
EOF
}

locals {
  tshirtsize = jsondecode(var.prod).tshirt_size
  cpucount   = jsondecode(var.global).tshirtsizes[local.tshirtsize].cpucount
}

output "cpucount" {
  value = local.cpucount
}

