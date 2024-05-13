variable "hcloud_server" {
  type = object({
    this = list(object({
      name = string
      ipv4 = string
      network = set(object({
        ip = string
      }))
    }))
  })
  default = {
    this : [
      { name : "a", ipv4 : "10.0.0.1", network: [{ip : "10.0.1.11"}] },
      { name : "b", ipv4 : "10.0.0.2", network: [{ip : "10.0.2.22"}] },
      { name : "c", ipv4 : "10.0.0.3", network: [{ip : "10.0.3.33"}] },
    ]
  }
}

output "name" {
  description = "List with names of the servers"
  value       = var.hcloud_server.this[*].name
}

output "test" {
  value = [
    for x in var.hcloud_server.this :
    "${x.name} + ${x.ipv4} + ${tolist(x.network)[0].ip}"
  ]
}
