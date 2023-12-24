variable "list_of_subnets" {
  default = [
    {
      subnet_type = "public"
      cidr_block  = "10.0.101.0/24"
      av_zone     = "us-west-1a"
    },
    {
      subnet_type = "public"
      cidr_block  = "10.0.102.0/24"
      av_zone     = "us-west-1b"
    },
    {
      subnet_type = "private"
      cidr_block  = "10.0.1.0/24"
      av_zone     = "us-west-1a"
    },
    {
      subnet_type = "private"
      cidr_block  = "10.0.2.0/24"
      av_zone     = "us-west-1b"
    }
  ]
}

module "subnets" {
  source   = "./subnets"
  for_each = toset(var.list_of_subnets)
  vpc_id   = "vpc-0627130d668a04f24"
  data     = each.value
}
