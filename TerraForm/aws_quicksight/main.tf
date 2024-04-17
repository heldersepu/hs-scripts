provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

resource "aws_quicksight_data_set" "example" {
  data_set_id = "example-id"
  name        = "example-name"
  import_mode = "SPICE"

#   physical_table_map {
#     physical_table_map_id = "example-id"
#     s3_source {
#       data_source_arn = aws_quicksight_data_source.example.arn
#       input_columns {
#         name = "Column1"
#         type = "STRING"
#       }
#       upload_settings {
#         format = "JSON"
#       }
#     }
#   }
}

resource "aws_quicksight_analysis" "my-test-analysis" {
  analysis_id = "my-first-analysis"
  name        = "my-first-analysis"

  definition {
    data_set_identifiers_declarations {
      data_set_arn = aws_quicksight_data_set.example.arn
      identifier   = "my_unique_identifier"
    }
    sheets {
      title        = "my-first-sheet"
      sheet_id     = "new-sheet-id"
      content_type = "INTERACTIVE"
    }
  }

#   permissions {
#     actions   = local.permissions
#     principal = "my_quicksight_account"
#   }
}