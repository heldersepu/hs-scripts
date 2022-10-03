provider "sumologic" {
  access_id   = "suhJx3NDC0i3cJ"
  access_key  = "yW47sLJSoj7ycDoy9Xx6w5JkPlNo6hYAVre6XtLTCQe8d51O1n9MpkSChj71B2Sk"
  environment = "us2"
}

resource "sumologic_collector" "example_collector" {
  name     = "Test Collector123"
  category = "my/source/category2"
}

resource "sumologic_role" "example_role" {
  name        = "TestRole123"
  description = "Testing resource sumologic_role"

  lifecycle {
    ignore_changes = [users]
  }
}

resource "sumologic_user" "example_user1" {
  first_name = "Jon"
  last_name  = "Doe"
  email      = "jon.doe@gmail.com"
  active     = false
  role_ids   = ["${sumologic_role.example_role.id}"]
}

resource "sumologic_user" "example_user2" {
  first_name = "Jane"
  last_name  = "Smith"
  email      = "jane.smith@gmail.com"
  role_ids   = ["${sumologic_role.example_role.id}"]
}

output "example_user1_id" {
  value = sumologic_user.example_user1.id
}

output "example_user1_name" {
  value = "${sumologic_user.example_user1.first_name} ${sumologic_user.example_user1.last_name}"
}
