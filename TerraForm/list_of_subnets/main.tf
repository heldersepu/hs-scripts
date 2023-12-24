variable "list_of_subnets" {
  default = [
    {
      subnet_type = "public"
      cidr_block  = "172.31.1.0/24"
      av_zone     = "us-east-1a"
    },
    {
      subnet_type = "public"
      cidr_block  = "172.31.2.0/24"
      av_zone     = "us-east-1b"
    },
    {
      subnet_type = "private"
      cidr_block  = "172.31.3.0/24"
      av_zone     = "us-east-1a"
    },
    {
      subnet_type = "private"
      cidr_block  = "172.31.4.0/24"
      av_zone     = "us-east-1b"
    }
  ]
}

module "subnets" {
  source   = "./subnets"
  for_each = { for k, v in var.list_of_subnets : k => v }
  vpc_id   = "vpc-0627130d668a04f24"
  data     = each.value
}

output "subnets" {
  value = module.subnets
}
