/*
output "aws_availability_zones_names" {
  value = "${data.aws_availability_zones.available.names}"
}

output "aws_availability_zones_names_len" {
  value = "${length(data.aws_availability_zones.available.names)}"
}

# output "aws_s3_bucket_name" {
#   value = "${aws_s3_bucket.sample_bucket12629.*.id}"
# }
#
# output "aws_subnet_cidr_block" {
#   value = "${aws_subnet.app1.*.cidr_block}"
# }
#
# output "aws_subnet_name" {
#   value = "${aws_subnet.app1.*.id}"
# }

output "var_aws_vpc_cidr_block_0" {
  value = "${cidrsubnet(var.cidr,2,0)}"
}

output "var_aws_vpc_cidr_block_1" {
  value = "${cidrsubnet(var.cidr,2,1)}"
}

output "aws_vpc_cidr_block" {
  value = "${aws_vpc.myvpc.*.cidr_block}"
}

output "aws_vpc_name" {
  value = "${aws_vpc.myvpc.*.id}"
}

output "testing_lookup" {
  value = "${lookup(var.ip_ranges, "de", "10.10.10.0/24")}"
}

output "testing_zipmap" {
  value = "${zipmap(data.aws_availability_zones.available.names, data.aws_availability_zones.available.names)}"
}

output "test_subnets" {
  value = "${data.template_file.test_subnets.*.rendered}"
}

output "list_test" {
  value = "${var.some_ips[0]}"
}

output "ip" {
  value = "${var.ip_ranges["de"]}"
}

output "b11_ips" {
  value = "${module.bucket11.ips}"
}

output "zzz" {
  value = "${local.test}"
}

output "complex_map" {
  value = "${var.complex_map}"
}

output "complex_map__length" {
  value = "${length(var.complex_map)}"
}

output "complex_map__first" {
  value = "${var.complex_map[0]}"
}
*/