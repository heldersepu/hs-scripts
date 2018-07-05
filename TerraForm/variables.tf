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

variable "ec2_enabled" {
  default = 1
}

variable "ec2_add_volume" {
  default = 1
}

variable "win_ec2_enabled" {
  default = 0
}

variable "vpn_enabled" {
  default = 0
}

variable "vpc_enabled" {
  default = 1
}

variable "buckets" {
  default = 1
}

variable "prevent_destroy" {
  type    = "string"
  default = "false"
}

variable "cidr" {
  default = "10.35.112.0/21"
}

variable "sshkey" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnf/P+jNQU5tqfVTfdAd92jwWCE6NZKJLxuvJB+zog/PV1rZpLMcKuGICNQt1ksU/yZR0Xq2oSiDIy4tYH7QzCMjMpRiZvdQINJZDeidtPDNSQWGn3dfKS5yHfge3/4taZ0cfnkZ4qHcLVZzfq+PvPmQn9gB1nqYZeHEPK59dWHaa8QLOnrE/IDJ8wPE/yMd1W4xitjkaTrEOC4xbyOiZFtgo/mpR97Z2uKn/nx8nWLg1nwhPhQOffYkReIji8FY67d7bbBpgGerYjEmZijgtW3aIjtKTBdiOu5E012RoCxXD4sO/cElqU/TJKg3djXyvAze/WmKafEgL499Zqty0J hsepulveda@mlla1851.magicleap.ds"
}
