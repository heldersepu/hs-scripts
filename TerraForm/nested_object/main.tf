variable "test" {
  type = set(object({
    details = string

    nestedone = set(object({
      label = string
      conditions = set(object({
        expression = string
      }))
    }))
  }))
  default = [
    {
      details = "aa"
      nestedone = [
        {
          label = "aab"
          conditions = [
            { expression = "foo" }
          ]
        },
        {
          label = "aax"
          conditions = [
            { expression = "bar" }
          ]
        }
      ]
    },
    {
      details = "bb"
      nestedone = [
        {
          label = "bbc"
          conditions = [
            { expression = "123" }
          ]
        }

      ]
    }
  ]
}

terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.2.1"
    }
  }
}

provider "pagerduty" {
  token = "6GsKp9Y5_c6axFRQvMTv"
}

output "test" {
  value = toset(flatten(var.test[*].nestedone))
}

resource "pagerduty_event_orchestration_router" "test" {
  event_orchestration = "pagerduty_event_orchestration.my_monitor.id"
  set {
    id = "start"
    dynamic "rule" {
      for_each = flatten(var.test[*].nestedone)

      content {
        label = rule.value.label
        dynamic "condition" {
          for_each = rule.value.conditions
          content {
            expression = condition.value.expression
          }
        }
        actions {
          route_to = pagerduty_service.database.id
        }
      }
    }
  }
  catch_all {
    actions {
      route_to = "unrouted"
    }
  }
}