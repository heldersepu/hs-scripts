variable "server_ip_configs" {
  default = {
    mgmt               = { ct = 1 }
    applicationgateway = { ct = 1 }
    monitor            = { ct = 1 }
    app                = { ct = 3 }
  }
}

locals {
  server_ip_configs_mapped = flatten([
    for server, count in var.server_ip_configs : [
      for i in range(count.ct) : {
        "name" = join("-", [server, i + 1])
      }
    ]
  ])
}


output "myout" {
  value = local.server_ip_configs_mapped
}
