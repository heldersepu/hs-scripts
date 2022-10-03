resource "aws_kms_key" "data_bucket_kms" {
  count       = 0
  description = "This key is used to encrypt bucket data related bucket objects"
}

resource "aws_kms_alias" "data_bucket_kms" {
  count         = 0
  name          = "alias/databucketkey"
  target_key_id = aws_kms_key.data_bucket_kms[0].key_id
}
