# hs-scripts terraform
 A collection of terraform scripts
// Source - https://stackoverflow.com/questions/70151358/terraform-how-to-properly-implement-delay-with-time-sleep-resource
// Posted by Alex Konkin
// Retrieved 24/08/2026, License - null

resource "time_sleep" "wait_3_seconds" {
  create_duration = "3s"
}

resource "null_resource" "topic_events" {
  triggers = {
    always_run = timestamp()
    topic = var.topic_name
  }
  depends_on = [time_sleep.wait_3_seconds]
}
