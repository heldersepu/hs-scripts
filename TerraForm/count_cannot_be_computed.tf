resource "aws_ebs_volume" "evol" {
  count             = "1"
  availability_zone = "us-east-1a"
  size              = "5"
}

module "test" {
  source = "./aws_keys"
  test   = aws_ebs_volume.evol[0].arn
}
