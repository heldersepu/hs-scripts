variable "ip_ranges" {
  type = "map"

  default = {
    "de" = "10.13.112.0/21"
    "qa" = "10.13.120.0/21"
    "pr" = "10.13.136.0/21"
  }
}

variable "some_ips" {
  type = "list"

  default = [
    "127.0.0.0/32",
    "192.168.0.0/32",
  ]
}

variable "enabled" {
  default = 0
}

variable "vpc_enabled" {
  default = 0
}

variable "buckets" {
  default = 1
}

variable "prevent_destroy" {
  type    = "string"
  default = "false"
}
