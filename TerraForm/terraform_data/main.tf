resource "terraform_data" "test" {
  input = "test123"
  provisioner "local-exec" {
    command = "hostname"
  }
}

output "test" {
  value = terraform_data.test.output
}
