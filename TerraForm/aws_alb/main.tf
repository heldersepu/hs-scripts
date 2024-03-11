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

output "elb_arn" {
  value = aws_alb.lb.arn
}
