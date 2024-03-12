provider "aws" {
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
  region                   = "us-east-1"
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0627130d668a04f24"]
  }
}

resource "aws_alb" "lb" {
  name    = "test"
  subnets = [data.aws_subnets.subnets.ids[0], data.aws_subnets.subnets.ids[2]]

}

resource "aws_lb_listener" "x" {
  load_balancer_arn = aws_alb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_iam_server_certificate.dummy.arn

  default_action {
    type = "redirect"

    redirect {
      port        = "80"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_s3_bucket" "test" {
  bucket = "test456345245"
}

data "aws_elb_service_account" "lb" {}
data "aws_iam_policy_document" "lb_access_logs_policy" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.test.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.lb.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "lb_access_logs_bucket_policy" {
  bucket = aws_s3_bucket.test.id
  policy = data.aws_iam_policy_document.lb_access_logs_policy.json
}

output "elb_arn" {
  value = aws_alb.lb.arn
}

output "s3_arn" {
  value = aws_s3_bucket.test.arn
}
