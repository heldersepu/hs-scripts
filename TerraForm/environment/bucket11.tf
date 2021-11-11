resource "aws_s3_bucket" "sample_bucket1111" {
  count  = var.enabled
  bucket = "my-tf-test-bucket1111"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.sample_bucket1111.*.id
}
