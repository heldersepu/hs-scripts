provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "sample_bucket2222" {
  bucket = "my-tf-test-bucket2222"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev2222"
  }
}

resource "aws_s3_bucket_object" "k8s-state" {
  for_each = fileset("${path.module}/data", "**/*")
  bucket   = aws_s3_bucket.sample_bucket2222.bucket
  key      = each.value
  content  = data.template_file.data[each.value].rendered
  etag     = filemd5("${path.module}/data/${each.value}")
}

data "template_file" "data" {
  for_each = fileset("${path.module}/data", "**/*")
  template = "${file("${path.module}/data/${each.value}")}"
  vars = {
    bucket_id  = aws_s3_bucket.sample_bucket2222.id
    bucket_arn = aws_s3_bucket.sample_bucket2222.arn
  }
}
