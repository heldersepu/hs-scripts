resource "aws_acm_certificate" "default" {
  count       = 0
  domain_name = "test.azurewebsites.net"

  # Which method to use for validation. DNS or EMAIL are valid,
  # NONE can be used for certificates that were imported into ACM and then into Terraform.
  validation_method = "NONE"

  subject_alternative_names = ["*.test.azurewebsites.net"]

  tags = {
    Terraformed = "true"
  }
}

resource "aws_route53_zone" "zone" {
  count         = "${var.enabled}"
  name          = "test.azurewebsites.net"
  force_destroy = true
}

resource "aws_route53_record" "cert_validation" {
  count   = 0
  name    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${aws_route53_zone.zone.id}"
  records = ["${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  count           = 0
  certificate_arn = "${aws_acm_certificate.default.arn}"

  timeouts {
    create = "20m"
  }
}


resource "aws_route53_record" "elb_external_p" {
  count   = "${var.enabled}"
  zone_id = "${aws_route53_zone.zone.id}"
  name    = "pi-3.test.azurewebsites.net"
  type    = "A"

  alias {
    name                   = "p-external-802436749.us-east-1.elb.amazonaws.com"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "elb_external_s" {
  count   = "${var.enabled}"
  zone_id = "${aws_route53_zone.zone.id}"
  name    = "s4-3.test.azurewebsites.net"
  type    = "A"

  alias {
    name                   = "s-external-1555626742.us-east-1.elb.amazonaws.com"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = false
  }
}