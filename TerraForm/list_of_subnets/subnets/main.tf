variable "vpc_id" {
  description = "vpc_id"
}

variable "data" {
  description = "object with subnet data"
}

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.data.sub_cidr
  availability_zone = var.data.sub_av_zone
  tags = {
    subnet_type = var.data.subnet_type
  }
}

output "subnet" {
  value = aws_subnet.subnet
}
