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

variable "device_names" {
  default = [
    "/dev/sdj",
    "/dev/sdk",
    "/dev/sdl",
    "/dev/sdm",
    "/dev/sdn",
  ]
}

variable "enabled" {
  default = 0
}

variable "ec2_enabled" {
  default = 1
}

variable "ec2_add_volume" {
  default = 4
}

variable "nslookup_record" {
  default = "google.com"
}

variable "ubuntu_ec2_enabled" {
  default = 1
}

variable "alpine_ec2_enabled" {
  default = 0
}

variable "win_ec2_enabled" {
  default = 0
}

variable "vpn_enabled" {
  default = 0
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

locals {
  test   = "${var.cidr}"
  sshkey = "${file("~/Downloads/AWS_keys/test.pem.pub")}"
}


variable "complex_map" {
  type = "list"

  default = [
    {
      name = "staging"
      value1 = [20,12]
      value2 = false
      maps = {
        one = 111
        two = 222
      }
    },
    {
      name = "production"
      value1 = [50,52]
      value2 = true
      maps = {
        uno = 111
        due = 222
      }
    }
  ]
}