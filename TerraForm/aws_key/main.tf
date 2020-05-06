provider "aws" {
  region = "us-east-1"
}

resource "random_string" "key" {
  length  = 8
  special = false
  keepers = {
    build_number = timestamp()
  }
}

resource "null_resource" "download_key" {
  triggers = {
    build_number = timestamp()
  }

  provisioner "local-exec" {
    when    = create
    command = "aws s3api get-object --bucket bucket123456123654 --key dir/data ${path.module}/${random_string.key.result}"
  }
}

resource "aws_key_pair" "project" {
  depends_on = [null_resource.download_key]
  key_name   = "project"
  public_key = file("${path.module}/${random_string.key.result}")
}
