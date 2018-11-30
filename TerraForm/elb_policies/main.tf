provider "aws" {
  region = "us-east-1"
}

resource "aws_elb" "elb" {
  name    = "elbTest"
  subnets = ["${aws_subnet.app.id}"]

  listener {
    instance_port      = 8000
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.dummy.arn}"
  }
}

resource "aws_lb_cookie_stickiness_policy" "cookie_stickiness_policy" {
  name                     = "cookieStickinessPolicy"
  load_balancer            = "${aws_elb.elb.id}"
  lb_port                  = "443"
  cookie_expiration_period = "600"
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


resource "null_resource" "listener_policy" {
  depends_on = ["aws_lb_cookie_stickiness_policy.cookie_stickiness_policy", "aws_load_balancer_policy.policy_tls_1_1"]
  triggers {
    load_balancer_name = "${aws_elb.elb.name}"
  }

  provisioner "local-exec" {
    when    = "create"
    command = "aws elb set-load-balancer-policies-of-listener --load-balancer-name ${aws_elb.elb.name} --load-balancer-port 443 --policy-names policy-tls-1-1 cookieStickinessPolicy"
  }
}

