variable "example" {
  description = "Example complex object"

  type = list(object({
    name = string
    size = object({
      height = number
      length = number
    })
  }))

  validation {
    condition     =  alltrue([
      for v in var.example : v.size.height > 5
    ])
    error_message = "Your height is expected to be greater than 5."
  }
}

output "test" {
  value = var.example
}