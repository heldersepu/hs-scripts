resource "random_string" "key" {
  length  = 32
  special = false
}

output "test" {
  value = random_string.key.result
}