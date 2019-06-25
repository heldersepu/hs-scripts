locals {
  s3_expiration = 50
}

resource "aws_s3_bucket" "sample_bucket12629" {
  count  = "${var.buckets}"
  bucket = "my-tf-test-bucket12629"
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }

  lifecycle_rule {
    id      = "BucketExpiration"
    enabled = true

    expiration {
      days = "${local.s3_expiration}"
    }
  }

  lifecycle_rule {
    id      = "ColdStorage"
    enabled = "${local.s3_expiration > 100 ? true: false}"

    transition {
      days          = 100
      storage_class = "GLACIER"
    }
  }

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_glacier_vault" "glacier_vault" {
  count = "${var.buckets}"
  name  = "ColdStorage"
}
