variable "hcloud_server" {
  type = object({
    this = list(object({
      name = string
      ipv4 = string
    }))
  })
  default = {
    this : [
      { name : "a", ipv4 : "10.0.0.1" },
      { name : "b", ipv4 : "10.0.0.2" },
      { name : "c", ipv4 : "10.0.0.3" },
    ]
  }
}

output "name" {
  description = "List with names of the servers"
  value       = var.hcloud_server.this[*].name
}

output "public_ip" {
  description = "List with public IPv4 IPs of the instances"
  value       = var.hcloud_server.this[*].ipv4
}

output "test" {
  value = [
    for x in var.hcloud_server.this :
    "${x.name} + ${x.ipv4}"
  ]
}
