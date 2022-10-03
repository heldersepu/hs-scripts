resource "aws_instance" "ubuntu" {
  count                  = var.ubuntu_ec2_enabled
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "m5d.xlarge"
  key_name               = aws_key_pair.sshkey.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = data.aws_availability_zones.available.names[0]
  user_data              = file("${path.module}/userdata.sh")

  tags = {
    Terraformed = "true"
    Name        = "ubuntu"
  }

  lifecycle {
    ignore_changes        = [ebs_optimized, volume_tags, ebs_block_device]
    create_before_destroy = true
    prevent_destroy       = false
  }

  provisioner "file" {
    source      = "~/.bash_history"
    destination = "~/.bash_history"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "file" {
    source      = "~/Downloads/GlobalProtect_deb-4.1.2.0-6.deb"
    destination = "/tmp/GlobalProtect_deb-4.1.2.0-6.deb"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "file" {
    source      = "~/VPN.sh"
    destination = "~/VPN.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "file" {
    source      = "~/.ssh"
    destination = "~"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "file" {
    source      = "~/.aws"
    destination = "~"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -qq",
      "sudo apt-get -qq install python-pip build-essential golang-go > /dev/null",
      "sudo apt-get -qq install net-tools unzip ansible expect awscli > /dev/null",
      "wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip",
      "unzip terraform_0.11.11_linux_amd64.zip",
      "sudo mv terraform /usr/local/bin/",
      "pip install --quiet --upgrade pip",
      "sudo apt-get -qq install /tmp/GlobalProtect_deb-4.1.2.0-6.deb > /dev/null",
      "mkdir code && cd code",
      "git clone --quiet https://github.com/heldersepu/hs-scripts.git",
      "git clone --quiet https://github.com/jamesob/desk.git",
      "cd desk && sudo make install",
      "printf \"\n# Hook for desk activation\n\" >> ~/.bashrc",
      "echo '[ -n \"$DESK_ENV\" ] && source \"$DESK_ENV\" || true' >> ~/.bashrc",
      "echo '' > ~/.ssh/known_hosts",
      "sudo rm -f /etc/update-motd.d/*",
      "echo ''",
      "go version",
      "aws --version",
      "desk --version",
      "make --version",
      "ansible --version",
      "terraform --version",
      "echo ${self.public_dns}",
      "echo ''",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "file" {
    source      = "~/.desk"
    destination = "~"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }

  provisioner "local-exec" {
    command     = data.template_file.nslookup_check.rendered
    interpreter = ["/bin/bash", "-c"]
  }
}

data "template_file" "nslookup_check" {
  template = file("${path.module}/nslookup_check.sh")

  vars {
    nslookup_record = var.nslookup_record
    nslookup_server = count.index
  }
}
