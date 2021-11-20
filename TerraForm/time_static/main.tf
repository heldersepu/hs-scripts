resource "time_static" "last_run" {}

output "current_time" {
  value = time_static.last_run.unix
}