data "template_file" "test_subnets" {
  count    = 8
  template = "$${cidr}"

  vars {
    cidr = "${cidrsubnet(var.cidr, 3, count.index)}"
  }
}
