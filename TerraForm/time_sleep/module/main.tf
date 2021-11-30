resource "time_sleep" "wait_3_seconds" {
  create_duration = "3s"
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    when    = create
    command = "date"
  }
  depends_on = [time_sleep.wait_3_seconds]
}