resource "aws_s3_bucket" "sample_bucket2222" {
  count  = "${var.enabled}"
  bucket = "my-tf-test-bucket2222"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev2222"
  }
}
