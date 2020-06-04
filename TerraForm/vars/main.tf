variable "build-number" {
  type    = "string"
  default = "0"
}

output "test" {
  value = "${var.build-number}"
}
