resource "aws_instance" "win2016" {
  count                  = var.win_ec2_enabled
  ami                    = data.aws_ami.win2016.id
  instance_type          = "m5.large"
  key_name               = aws_key_pair.sshkey.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  get_password_data      = true

  ephemeral_block_device {
    virtual_name = "ephemeral0"
    device_name  = "xvde"
    no_device    = false
  }

  tags {
    Terraformed = "true"
    Name        = "win2016"
  }

  volume_tags {
    Terraformed = "true"
    Name        = "win2016 volume root"
  }

  provisioner "remote-exec" {
    inline = ["ipconfig > ip.log"]

    connection {
      type     = "winrm"
      user     = "Administrator"
      password = rsadecrypt(self.password_data, file("~/Downloads/AWS_keys/test.pem"))
      host     = self.public_dns
      timeout  = "10m"
      https    = false
      insecure = true
    }
  }
}
