variable "server_ip_configs" {
  default = {
    mgmt               = { ct = "1" }
    applicationgateway = { ct = "1" }
    monitor            = { ct = "1" }
    app                = { ct = "3" }
  }
}

output "myout" {
  value = [for k, v in var.server_ip_configs : { "name" = join("-", [k, v.ct]) }]
}
