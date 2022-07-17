
data "aws_route53_zone" "main" {
  zone_id = "Z04007531QNA6FGJV5TRJ"
}

data "aws_cloudfront_distribution" "main" {
  id = "E3LOOWLVWZEGSH"
}

output "cd_hz" {
  value = data.aws_cloudfront_distribution.main.hosted_zone_id
}

resource "aws_route53_record" "main-ns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "foobar.idexo.io"
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.main.domain_name
    zone_id                = data.aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}