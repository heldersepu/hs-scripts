variable "services" {
  default = {
    logs = {
      name      = "logs",
      ports     = ["9200", "7000"],
      protocol  = ["TCP"]
      namespace = "ns1"
    },
    elk = {
      name      = "elk",
      ports     = ["9200", "7000", "5044", "8080"],
      protocol  = ["TCP"]
      namespace = "ns2"
    },
    syslog = {
      name      = "syslog"
      ports     = ["514", "5200"]
      protocol  = ["TCP", "UDP"]
      namespace = "ns3"
    }
  }
}

locals {
  svc_mapping = {
    for svc in var.services : svc.name => flatten([
      for port in svc.ports : [
        for protocol in svc.protocol : {
          ports     = [port]
          protocol  = [try(length(protocol), 0) > 0 ? protocol : "tcp"]
          namespace = svc.namespace
        }
      ]
    ])
  }
}

output "test" {
  value = local.svc_mapping
}