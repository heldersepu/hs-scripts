run "bad_environment" {
  command = plan

  variables {
    environment = "test"
  }
  expect_failures = [var.environment]
}

run "bad_instance_type" {
  command = plan
  variables {
    instance_type = "test"
  }
  expect_failures = [var.instance_type]
}

run "ok" {
  command = plan

  variables {
    environment   = "prod"
    instance_type = "t2.xlarge"
  }
  assert {
    condition     = output.validation == "Environment prod and instance t2.xlarge"
    error_message = "Environment and instance test"
  }
}