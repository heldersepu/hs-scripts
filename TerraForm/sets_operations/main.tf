variable "dev" {
  type    = set(string)
  default = ["a", "b", "c", "d"]
}

variable "prd" {
  type    = set(string)
  default = ["c", "d", "e", "f"]
}

output "UNION" {
  value = setunion(var.dev, var.prd)
}

output "SUBTRACT" {
  value = setsubtract(var.dev, var.prd)
}

output "INTERSECTION" {
  value = setintersection(var.dev, var.prd)
}

output "PRODUCT" {
  value = setproduct(var.dev, var.prd)
}