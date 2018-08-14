resource "aws_load_balancer_policy" "policy_tls_1_1" {
  count              = "${var.enabled}"
  load_balancer_name = "${var.elb_name}"
  policy_name        = "policy-tls-1-1"
  policy_type_name   = "SSLNegotiationPolicyType"

  policy_attribute {
    name  = "Reference-Security-Policy"
    value = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }

  lifecycle {
    ignore_changes = ["policy_attribute"]
  }
}

resource "aws_load_balancer_listener_policy" "vault_server_listener_policies" {
  count              = "${var.enabled}"
  load_balancer_name = "${var.elb_name}"
  load_balancer_port = 443

  policy_names = [
    "${aws_load_balancer_policy.policy_tls_1_1.policy_name}",
  ]

  lifecycle {
    ignore_changes = ["policy_names"]
  }
}
