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
  count         = 0
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
