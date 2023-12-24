variable "vpc_id" {
  description = "the vpc_id"
}

variable "data" {
  description = "object with subnet data"
}

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.data.cidr_block
  availability_zone = var.data.av_zone
  tags = {
    subnet_type = var.data.subnet_type
  }
}

output "subnet" {
  value = aws_subnet.subnet
}
