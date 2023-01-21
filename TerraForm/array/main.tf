locals {
  json = {
      "4" = {
        "no_alert_for_skipped_runs" = false
        "on_failure" = [
          "foo1@foo.com",
          "foo2@foo.com",
        ]
        "on_start" = [
          "foo1@foo.com",
          "foo2@foo.com",
        ]
    }
  }
}

output "data" {
    value = element(values(local.json), 1).on_start
}