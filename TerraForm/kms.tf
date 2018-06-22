resource "aws_kms_key" "data_bucket_kms" {
  description = "This key is used to encrypt bucket data related bucket objects"
}

resource "aws_kms_alias" "data_bucket_kms" {
  name          = "alias/databucketkey"
  target_key_id = "${aws_kms_key.data_bucket_kms.key_id}"
}
