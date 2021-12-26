provider "aws" {
  region = "us-east-1"
}

resource "aws_elastic_beanstalk_configuration_template" "mytemplate" {
  for_each            = toset(["app1", "app2"])
  name                = "app-type1-base"
  application         = each.value
  solution_stack_name = "64bit Amazon Linux 2015.09 v2.0.8"

  dynamic "setting" {
    for_each = toset(sort(["ELBSubnets", "Subnets", "VPCId"]))
    content {
      namespace = "aws:ec2:vpc"
      name      = setting.value
      value     = "blah"
    }
  }
}

resource "aws_elastic_beanstalk_configuration_template" "mytemplate2" {
  count               = 3
  name                = "app-type1-base"
  application         = "each.value"
  solution_stack_name = "64bit Amazon Linux 2015.09 v2.0.8"

  dynamic "setting" {
    for_each = count.index < 2 ? ["1"] : []
    content {
      namespace = "aws:ec2:vpc"
      name      = setting.value
      value     = "blah"
    }
  }
}

