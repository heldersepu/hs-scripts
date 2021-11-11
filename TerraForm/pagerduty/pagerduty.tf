# Configure the PagerDuty provider
provider "pagerduty" {
  token = "6GsKp9Y5_c6axFRQvMTv"
}

# Create a PagerDuty team
resource "pagerduty_team" "engineering" {
  name        = "Engineering"
  description = "All engineering"
}

resource "pagerduty_user" "example" {
  name  = "Howard James"
  email = "howard.james@example.domain"
  teams = ["${pagerduty_team.engineering.id}"]
}

data "pagerduty_extension_schema" "webhook" {
  name = "Generic V2 Webhook"
}

resource "pagerduty_escalation_policy" "foo" {
  name      = "Engineering Escalation Policy"
  num_loops = 2

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "user"
      id   = pagerduty_user.example.id
    }
  }
}

resource "pagerduty_service" "example" {
  name                    = "My Web App"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.foo.id
}

resource "pagerduty_extension" "slack" {
  name              = "My Web App Extension"
  extension_schema  = data.pagerduty_extension_schema.webhook.id
  extension_objects = ["${pagerduty_service.example.id}"]

  config = <<EOF
{
    "restrict": "any",
    "notify_types": {
            "resolve": false,
            "acknowledge": false,
            "assignments": false
    },
    "access_token": "XXX"
}
EOF
}
