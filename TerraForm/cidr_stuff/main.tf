locals {
  cidr_range = "10.35.136.0/21"
}

output "cidr_1__4-0" {
  value = cidrsubnet(local.cidr_range, 4, 0)
}

output "cidr_2__4-1" {
  value = cidrsubnet(local.cidr_range, 4, 1)
}

output "cidr_3__3-1" {
  value = cidrsubnet(local.cidr_range, 3, 1)
}

output "cidr_4__2-1" {
  value = cidrsubnet(local.cidr_range, 2, 1)
}

output "cidr_5__2-2" {
  value = cidrsubnet(local.cidr_range, 2, 2)
}

output "cidr_6__2-3" {
  value = cidrsubnet(local.cidr_range, 2, 3)
}
