resource "aws_dynamodb_table" "users_table" {
  name           = "UserProfileTable"
  billing_mode   = "PROVISIONED" # Or use "PAY_PER_REQUEST" for on-demand capacity
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "UserID"
  range_key      = "PostID"

  attribute {
    name = "UserID"
    type = "N"
  }

  attribute {
    name = "PostID"
    type = "N"
  }

}