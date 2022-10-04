resource "null_resource" "test" {
  count = 8
  triggers = {
    index = count.index % 3 + 1
  }
  provisioner "local-exec" {
    command = "echo 'test'"
  }
}