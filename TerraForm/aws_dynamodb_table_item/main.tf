provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

resource "aws_dynamodb_table" "my_table" {
  name         = "my_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "my_table" {
  table_name = aws_dynamodb_table.my_table.name
  hash_key   = aws_dynamodb_table.my_table.hash_key

  item = <<ITEM
{
  "id": {"S": "nameAndCodes"},
  "data": {"L": [
      {
        "M": {
          "code": { "S": "03"},
          "displayName": { "S": "name1"}
        }
      },
      {
        "M": {
          "code": { "S": "04"},
          "displayName": { "S": "name2"}
        }
      }
    ]
  }
}
ITEM
}