variable "enabled" {
  type        = string
  description = "to enable or not to enable"
  default     = 0
}

variable "ip_ranges" {
  type = map(string)
}
