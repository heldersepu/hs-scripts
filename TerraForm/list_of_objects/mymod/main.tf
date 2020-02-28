variable "data" {
  type = list(object({
    active      = bool
    description = string
  }))
}

output "mymap" {
  value = var.data
}
