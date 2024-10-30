locals {
  input_files = {
    for file in fileset(".", "**/*.yaml") :
    file => yamldecode(file("./${file}"))
  }
}

resource "terraform_data" "test" {
  provisioner "local-exec" {
    when    = create
    command = "python3 ./test.py '{\"x\":1}'"
  }
}

output "test" {
  value = terraform_data.test.output
}

output "yaml" {
  value = local.input_files
}

output "yaml_x" {
  value = try(local.input_files["test2.yaml"].abc, "default")
}
