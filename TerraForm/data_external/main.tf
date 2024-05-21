locals {
  base_dir = "."

  input_files = {
    for file in fileset(local.base_dir, "**/*.yaml") :
    file => yamldecode(file("${local.base_dir}/${file}"))
  }
}

data "external" "test" {
  program = ["python3", "hostname.py"]
}

resource "terraform_data" "test" {
  for_each         = local.input_files
  triggers_replace = each.value

  provisioner "local-exec" {
    when    = create
    command = "python3 ./hostname2.py '${jsonencode(each.value)}'"
  }
}

output "test" {
  value = data.external.test.result
}

output "test2" {
  value = terraform_data.test
}