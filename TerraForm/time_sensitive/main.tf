variable "groups" {
  default = [
    {
      version  = "v1"
      var1     = 1
      timeslot = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    },
    {
      version  = "v2"
      var1     = 2
      timeslot = ["Saturday", "Sunday"]
    },
  ]
}

locals {
  data = distinct(flatten([
    for key, value in var.groups : [
      value
    ] if contains(value.timeslot, formatdate("EEEE", timestamp()))
  ]))

}

output "day_of_week" {
  value = formatdate("EEEE", timestamp())
}
output "data" {
  value = local.data[0]
}