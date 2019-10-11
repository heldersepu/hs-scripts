variable "emails" {
  default = [
      "jdoe@bla.com",
      "ppan@foo.com"
  ]
}


data "okta_user" "users" {
  for_each = toset(var.emails)
  
  search {
    name  = "profile.email"
    value = each.value
  }
}


output "users" {
  value = data.okta_user.users["jdoe@bla.com"]
}
