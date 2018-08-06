data "template_file" "test_subnets" {
  count    = 8
  template = "$${cidr}"

  vars {
    cidr = "${cidrsubnet(var.cidr, 3, count.index)}"
  }
}

data "template_file" "user_data" {
  template = "${format("%s%s", file("scripts/common.sh"), file("scripts/user_data.sh"))}"

  vars {
    data  = "${jsonencode(var.cidr)}"
  }
}
