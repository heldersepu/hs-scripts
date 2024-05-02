locals {
  dir_hash = (
    {
      for f in fileset(path.root, "../*.tf") :
      f => filesha256(f)
    }
  )
}

output "test" {
  value = local.dir_hash
}
