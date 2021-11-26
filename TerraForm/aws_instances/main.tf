provider "aws" {
  region = "us-east-1"
}

data "aws_instances" "test" {
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_cloudwatch_log_metric_filter" "test" {
  name           = "test-metric-filter"
  pattern        = "[w1,w2,w3,w4!=\"*${data.aws_instances.test.private_ips[0]}*\",w5=\"*admin*\"]"
  log_group_name = "test_log_group_name"

  metric_transformation {
    name      = "test-metric-filter"
    namespace = "General"
    value     = 1
  }
}
