locals {
  batch_directory = "${path.module}/.."
  subdirectories = toset([
    for k, _ in fileset(local.batch_directory, "**") : dirname(k)
    if try(regex(".*/.*", dirname(k)), 0) == 0 && dirname(k) != "."
  ])
}

output "name" {
  value = local.subdirectories
}