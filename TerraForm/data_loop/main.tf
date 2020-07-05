provider "aws" {
  region = "us-east-2"
}

variable "alarms" {
  type = list(object({
    name          = string
    period        = number
    alarm_actions = list(string)
  }))

  default = [
    {
      name          = "group1-filter1-alarm"
      period        = 120
      alarm_actions = ["action1"]
    },
    {
      name          = "group1-filter2-alarm"
      period        = 300
      alarm_actions = ["action1", "action2"]
    },
    {
      name          = "group2-filter1-alarm"
      period        = 60
      alarm_actions = []
    },
  ]
}

data "aws_sns_topic" "actions" {
  for_each = toset(flatten([for x in var.alarms : x.alarm_actions]))
  name     = each.value
}

resource "aws_cloudwatch_metric_alarm" "alarms" {
  for_each            = { for x in var.alarms : x.name => x }
  alarm_name          = each.value.name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = each.value.name
  namespace           = "xyz-namespace"
  period              = each.value.period
  statistic           = "Sum"
  threshold           = "1"
  alarm_actions       = [for a in each.value.alarm_actions : data.aws_sns_topic.actions[a].arn]
}

output "actions" {
  value = data.aws_sns_topic.actions
}
