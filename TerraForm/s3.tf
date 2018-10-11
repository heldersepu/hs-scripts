resource "aws_s3_bucket" "sample_bucket12629" {
  count  = "${var.buckets}"
  bucket = "my-tf-test-bucket12629"
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_glacier_vault" "glacier_vault" {
  count  = "${var.buckets}"
  name = "ColdStorage"
}
