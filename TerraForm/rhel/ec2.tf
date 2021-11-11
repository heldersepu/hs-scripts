resource "aws_instance" "ubuntu" {
  for_each               = toset(["7", "8"])
  ami                    = data.aws_ami.rhel[each.value].id
  instance_type          = "m5d.xlarge"
  key_name               = aws_key_pair.sshkey.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  availability_zone      = data.aws_availability_zones.available.names[0]

  provisioner "remote-exec" {
    inline = [
      "python --version",
      "echo ${self.public_dns}",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_dns
    }
  }
}

resource "aws_key_pair" "sshkey" {
  key_name   = "sshkey"
  public_key = file("~/Downloads/AWS_keys/test.pem.pub")
}
