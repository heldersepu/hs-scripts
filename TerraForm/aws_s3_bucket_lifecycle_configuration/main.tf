provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

resource "aws_s3_bucket" "test" {
  bucket = "test456345245"
}

resource "aws_s3_bucket_lifecycle_configuration" "test" {
  bucket = aws_s3_bucket.test.id

  rule {
    id     = "Test1"
    status = "Enabled"

    filter {
      and {
        prefix                   = "test1/"
        object_size_greater_than = "1"
      }
    }
    expiration {
      days = 3
    }
  }

  rule {
    id     = "Test2"
    status = "Enabled"

    filter {
      prefix                   = "test2/"
      object_size_greater_than = "2"
    }
    expiration {
      days = 5
    }
  }
}
