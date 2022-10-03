resource "aws_instance" "wordpress" {
  ami                    = data.aws_ami.wordpress.id
  instance_type          = "m5.large"
  key_name               = aws_key_pair.sshkey.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = data.aws_availability_zones.available.names[0]

  tags = {
    Terraformed = "true"
    Name        = "wordpress"
  }

  lifecycle {
    ignore_changes  = [ami, user_data]
    prevent_destroy = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade",
      "sudo /opt/bitnami/apps/APPNAME/bnconfig --disable_banner 1",
      "sudo /opt/bitnami/ctlscript.sh restart nginx",
      "cat ./bitnami_credentials",
    ]

    connection {
      type        = "ssh"
      user        = "bitnami"
      private_key = file("~/Downloads/AWS_keys/test.pem")
      host        = self.public_ip
    }
  }
}
