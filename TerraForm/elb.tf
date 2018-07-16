resource "aws_elb" "elb" {
  name    = "elb"
  subnets = ["${aws_subnet.app1.id}"]

  listener {
    instance_port      = 8000
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.dummy.arn}"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Terraformed = "true"
    Name        = "elb"
  }
}

resource "aws_subnet" "test_app1" {
  count      = 0
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_load_balancer_policy" "policy_tls_1_1" {
  load_balancer_name = "${aws_elb.elb.name}"
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
  load_balancer_name = "${aws_elb.elb.name}"
  load_balancer_port = 443

  policy_names = [
    "${aws_load_balancer_policy.policy_tls_1_1.policy_name}",
  ]
}
