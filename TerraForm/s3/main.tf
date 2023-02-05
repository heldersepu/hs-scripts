provider "aws" {
  region      = "us-east-1"
}
variable "buckets" {
  type = map(any)
  default = {
    "in" : 180,
    "out" : 120,
    "in-archive" : 200,
    "out-archive" : 360
  }
}

resource "aws_s3_bucket" "bucket" {
  for_each = var.buckets
  bucket   = each.key
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  for_each = var.buckets
  bucket   = aws_s3_bucket.bucket[each.key].id
  rule {
    status = "Enabled"
    id     = "bucket-lifecycle-rule"
    expiration {
      days = each.value
    }
  }
}
