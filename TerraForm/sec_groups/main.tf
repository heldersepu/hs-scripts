variable "vpc_ids" {
  default = ["vpc-f8182000"]
  type = "list"
}

data "aws_security_groups" "sgs" {
  filter {
    name   = "vpc-id"
    values = "${var.vpc_ids}"
  }
}

data "aws_security_group" "sg" {
  count = "${length(data.aws_security_groups.sgs.ids)}"
  id    = "${element(data.aws_security_groups.sgs.ids, count.index)}"
}

output "sg_descriptions" {
  value = "${data.aws_security_group.sg.*.description}"
}
