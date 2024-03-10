variable "checkpoint_username" {
  type    = string
  default = "test"
}

output "user" {
  value = var.checkpoint_username
}