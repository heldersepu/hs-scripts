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
    command = <<EOF
    if [ "${var.nslookup_check}" != "" ]; then
      tries=0
      while true; do
        if [[ $tries -ge 30 ]]; then
          echo "ERROR !"
          exit 1;
        elif [[ $(nslookup ${var.nslookup_check} | grep -c "can't find") == 0 ]]; then
          echo "GOOD TO GO"
          exit 0;
        fi
        let "tries++"
        echo "Invalid response, will try again in 10 seconds. ($tries/30)"
        sleep 10
      done
    fi
EOF
  }
}
