provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_policy" "role_policy" {
  name   = "role_policy"
  policy = file("role.json")
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = file("ec2.json")
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.role_policy.arn
}

resource "aws_iam_instance_profile" "profile" {
  name = "my_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "instance" {
  ami                  = "ami-1c761163"
  instance_type        = "r5.large"
  iam_instance_profile = aws_iam_instance_profile.profile.name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "200"
    delete_on_termination = true
  }
}
