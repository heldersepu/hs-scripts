provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "win2016" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base*"]
  }
}

resource "aws_key_pair" "ssh" {
  key_name   = "ssh"
  public_key = file("~/Downloads/AWS_keys/test.pem.pub")
}

resource "aws_security_group" "open" {
  name = "open"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "win2016" {
  ami                    = data.aws_ami.win2016.id
  instance_type          = "m5.large"
  key_name               = aws_key_pair.ssh.key_name
  vpc_security_group_ids = ["${aws_security_group.open.id}"]
  get_password_data      = true

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

output "Administrator_Password" {
  value = rsadecrypt(aws_instance.win2016.password_data, file("~/Downloads/AWS_keys/test.pem"))
}
