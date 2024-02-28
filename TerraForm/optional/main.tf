variable "test" {
  type = list(object({
    name = string
    data = optional(map(string), {})
  }))
}

output "test" {
  value = [for x in var.test: try(x.data.foo, "") ]
}