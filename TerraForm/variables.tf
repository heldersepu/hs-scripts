variable "ip_ranges" {
  type = "map"

  default = {
    "de" = "10.13.112.0/21"
    "qa" = "10.13.120.0/21"
    "pr" = "10.13.136.0/21"
  }
}

variable "enabled" {
  default = 1
}
