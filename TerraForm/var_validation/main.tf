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
    error_message = "Bad value, Allow all is a bad practice ..."
  }

  validation {
    condition = alltrue([
      for v in var.network_acls : contains(["Allow", "Deny"], v.access)
    ])
    error_message = "Bad access, only [Allow,Deny]"
  }

  validation {
    condition = alltrue([
      for v in var.network_acls : contains(["Outbound", "Inbound"], v.direction)
    ])
    error_message = "Bad direction, only [Outbound,Inbound]"
  }
}
