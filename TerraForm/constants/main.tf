variable "enviroments" {
  type = "map"

  default = {
    "prod"  = "p"
    "stage" = "s"
    "qa"    = "q"
    "dev"   = "d"
    "sandb" = "x"
  }
}

output "enviroments" {
  value = "${var.enviroments}"
}
