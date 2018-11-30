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

resource "aws_lb_cookie_stickiness_policy" "cookie_stickiness_policy" {
  name                     = "cookieStickinessPolicy"
  load_balancer            = "${aws_elb.elb.id}"
  lb_port                  = "443"
  cookie_expiration_period = "600"
}

module "elb_policy_internal" {
  source   = "./elb_policy"
  enabled  = 1
  elb_name = "${aws_elb.elb.name}"
}
