provider "sumologic" {
  access_id   = "suhJx3NDC0i3cJ"
  access_key  = "yW47sLJSoj7ycDoy9Xx6w5JkPlNo6hYAVre6XtLTCQe8d51O1n9MpkSChj71B2Sk"
  environment = "us2"
}

resource "sumologic_collector" "example_collector" {
  name     = "Hosted Collector"
  category = "my/source/category"
}

resource "sumologic_role" "example_role" {
  name        = "TestRole"
  description = "Testing resource sumologic_role"
}

resource "sumologic_user" "example_user" {
  first_name = "Jon"
  last_name  = "Doe"
  email      = "jd@gmail.com"
  role_ids   = ["${sumologic_role.example_role.id}"]
}
