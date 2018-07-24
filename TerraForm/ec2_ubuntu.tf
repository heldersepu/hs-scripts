resource "aws_instance" "ubuntu" {
  count                  = "${var.ubuntu_ec2_enabled}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "m5d.large"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Terraformed = "true"
    Name        = "ubuntu"
  }

  lifecycle {
    ignore_changes  = ["ami", "user_data", "instance_type", "ebs_optimized", "volume_tags", "ebs_block_device"]
    prevent_destroy = false
  }

  provisioner "remote-exec" {
    inline = ["ls -la > test.log"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("~/Downloads/AWS_keys/test.pem")}"
      host        = "${self.public_dns}"
    }
  }
}
