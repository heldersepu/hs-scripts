variable "build-number" {
  type    = string
  default = "0"
}

output "test" {
  value = var.build-number
}


variable complex {
  type = object({
    gid = string
    access = object({
      id   = string
      type = string
    })
  })

  default = {
    gid = "00000003"
    access = {
      id   = "7ab1d382"
      type = "Role"
    }
  }
}

output "complex" {
  value = var.complex
}
