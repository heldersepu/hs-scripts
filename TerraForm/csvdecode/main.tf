locals {
  input_files = {
    for file in fileset(".", "*.txt") :
    file => csvdecode(file("./${file}"))
  }
}

data "external" "data" {
    for_each = tomap({ for x in local.input_files["data.txt"] : "${x.name}_${x.number}" => x })
    program = ["bash", "test.sh"]
}

data "external" "bad" {
    for_each = toset([ for x in local.input_files["bad.txt"] : x.data ])
    program = ["bash", "test.sh"]
}

output "data" {
  value = local.input_files
}