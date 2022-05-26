variable "network_acls" {
  type = map(object({
    direction = string
    access    = string
    prefix    = string
  }))

  validation {
    condition = alltrue([
      for v in var.network_acls : !(v.access == "Allow" && v.prefix == "*")
    ])
    error_message = "Bad value ..."
  }
}
