resource "aws_elb" "elb" {
  name    = "elb"
  subnets = ["${aws_subnet.app1.id}"]

  #TODO: disable this!
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  #TODO: enable this!
  /*
  listener {
    instance_port      = 8000
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    #ssl_certificate_id = "${var.acm_cert_arn}"
  }
  */

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
