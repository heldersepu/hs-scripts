provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

variable "funny-name-configs" {
  default = ["a", "b"]
}

variable "water-name-configs" {
  default = [{table_name:"a"},{table_name:"b"}]
}

resource "aws_glue_job" "water-name" {
  count       = length(var.funny-name-configs)
  name        = "water-name-${var.water-name-configs[count.index].table_name}"
  description = "water-name-${var.water-name-configs[count.index].table_name}"

  role_arn = "arn:aws:iam::621655500763:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport"
  command {
    script_location = "s3://foo/example.py"
  }
}
