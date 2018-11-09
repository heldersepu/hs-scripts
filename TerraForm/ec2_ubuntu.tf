resource "aws_instance" "ubuntu" {
  count                  = "${var.ubuntu_ec2_enabled}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "m5d.large"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"
  user_data              = "echo test"

  tags {
    Terraformed = "true"
    Name        = "ubuntu"
  }

  lifecycle {
    ignore_changes  = ["ami", "instance_type", "ebs_optimized", "volume_tags", "ebs_block_device"]
    create_before_destroy = true
    prevent_destroy = false
  }

  provisioner "remote-exec" {
    inline = [
      "ls -la > test.log",
      "sudo apt-get update",
      "sudo apt-get -y install gdebi-core python-minimal",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/Downloads/AWS_keys/test.pem")}"
      host        = "${self.public_dns}"
    }
  }

  provisioner "local-exec" {
    command = "${data.template_file.nslookup_check.rendered}"
  }
}

data "template_file" "nslookup_check" {
  template = "${file("${path.module}/nslookup_check.sh")}"

  vars {
    nslookup_record = "${var.nslookup_record}"
    nslookup_server = "${count.index}"
  }
}
