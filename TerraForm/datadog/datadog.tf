provider "datadog" {
  api_key = "123"
  app_key = "456"
}

resource "datadog_monitor" "avg_ec2_cpuutilization" {
  name    = "CPU is high on {{host.name}}"
  message = "CPU is high"
  query   = "avg(last_30m):max:aws.ec2.cpuutilization{environment:dev} by {host,name} > 96"
  type    = "query alert"

  evaluation_delay    = 900
  no_data_timeframe   = 120
  renotify_interval   = 0
  include_tags        = false
  require_full_window = false

  thresholds {
    critical          = 96
    critical_recovery = 95
    warning           = 90
    warning_recovery  = 85
  }

  tags = [
    "metric:cpu",
    "environment:dev",
  ]
}
