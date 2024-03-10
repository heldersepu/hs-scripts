resource "time_sleep" "wait" {
  count           = 15
  create_duration = "${count.index + 1}s"
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    when    = create
    command = "date"
  }
  depends_on = [time_sleep.wait]
}