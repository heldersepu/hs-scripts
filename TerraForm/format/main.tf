variable "id" {
  type    = string
  default = "xxx"
}

variable "k8s_namespaces" {
  type    = list(string)
  default = ["ns1", "ns2", "ns3"]
}

locals {
  members = [
    for n in var.k8s_namespaces :
    format("serviceAccount:${var.id}.svc.id.goog[%s/%s]", n, n)
  ]
}

output "members" {
  value = local.members
}