variable "test" {
  type = list(object({
    name = string
    data = optional(number, 0)
  }))
}

output "test" {
  value = var.test
}