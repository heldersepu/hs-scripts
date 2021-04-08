data "http" "allowed_networks_v1" {
  url = "https://raw.githack.com/heldersepu/hs-scripts/master/json/networks.json"
}

locals {
  allowed_networks_json = jsondecode(data.http.allowed_networks_v1.body)

  distinct_cidrs = distinct(flatten([
    for key, value in local.allowed_networks_json : [
      value.metadata.cidr
    ]
  ]))
}

output "data" {
  value = local.distinct_cidrs
}
