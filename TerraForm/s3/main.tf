provider "aws" {
  region = "us-east-1"
}

variable "buckets" {
  type = map(any)
  default = {
    "in" : { expiration : 180, transition : 0 },
    "out" : { expiration : 120, transition : 0 },
    "in-archive" : { expiration : 200, transition : 180 },
    "out-archive" : { expiration : 360, transition : 180 }
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
      days = each.value.expiration
    }
  }
  rule {
    status = each.value.transition > 0 ? "Enabled" : "Disabled"
    id     = "archive-bucket-lifecycle-rule"
    transition {
      days          = each.value.transition
      storage_class = "GLACIER"
    }
  }
}
