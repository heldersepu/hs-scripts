resource "aws_instance" "ubuntu" {
  count                  = "${var.ubuntu_ec2_enabled}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "m5d.xlarge"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"
  user_data              = "${file("${path.module}/userdata.sh")}"

  tags {
    Terraformed = "true"
    Name        = "ubuntu"
  }

  lifecycle {
    ignore_changes        = ["ami", "ebs_optimized", "volume_tags", "ebs_block_device"]
    create_before_destroy = true
    prevent_destroy       = false
  }

  provisioner "file" {
    source      = "~/.bash_history"
    destination = "~/.bash_history"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/Downloads/AWS_keys/test.pem")}"
      host        = "${self.public_dns}"
    }
  }

  provisioner "file" {
    source      = "~/Downloads/GlobalProtect_deb-4.1.2.0-6.deb"
    destination = "/tmp/GlobalProtect_deb-4.1.2.0-6.deb"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/Downloads/AWS_keys/test.pem")}"
      host        = "${self.public_dns}"
    }
  }

  provisioner "file" {
    source      = "~/VPN.sh"
    destination = "~/VPN.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/Downloads/AWS_keys/test.pem")}"
      host        = "${self.public_dns}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "ls -la > test.log",
      "sudo apt update",
      "sudo apt -y install awscli",
      "sudo apt -y install gdebi-core python-minimal",
      "sudo apt -y install net-tools unzip ansible",
      "wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip",
      "unzip terraform_0.11.11_linux_amd64.zip",
      "sudo mv terraform /usr/local/bin/",
      "sudo apt -y install /tmp/GlobalProtect_deb-4.1.2.0-6.deb",
      "echo ${self.public_dns}",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/Downloads/AWS_keys/test.pem")}"
      host        = "${self.public_dns}"
    }
  }

  provisioner "local-exec" {
    command     = "${data.template_file.nslookup_check.rendered}"
    interpreter = ["/bin/bash", "-c"]
  }
}

data "template_file" "nslookup_check" {
  template = "${file("${path.module}/nslookup_check.sh")}"

  vars {
    nslookup_record = "${var.nslookup_record}"
    nslookup_server = "${count.index}"
  }
}
