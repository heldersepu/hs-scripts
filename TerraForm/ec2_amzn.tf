resource "aws_instance" "amzn" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = "c5d.4xlarge"
  key_name               = aws_key_pair.sshkey.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = data.aws_availability_zones.available.names[0]

  tags = {
    Terraformed = "true"
    Name        = "amzn"
  }

  lifecycle {
    ignore_changes  = [ami, user_data]
    prevent_destroy = false
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "32"
    delete_on_termination = true
  }

  provisioner "local-exec" {
    command    = "echo ${self.public_ip}"
    on_failure = continue
  }
}
