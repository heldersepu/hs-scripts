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
#
# output "aws_vpc_cidr_block" {
#   value = "${aws_vpc.myvpc.*.cidr_block}"
# }
#
# output "aws_vpc_name" {
#   value = "${aws_vpc.myvpc.*.id}"
# }

output "testing_lookup" {
  value = "${lookup(var.ip_ranges, "de", "10.10.10.0/24")}"
}

output "testing_zipmap" {
  value = "${zipmap(data.aws_availability_zones.available.names, data.aws_availability_zones.available.names)}"
}
