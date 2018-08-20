resource "aws_instance" "suse12" {
  count                  = "${var.ec2_enabled}"
  ami                    = "${data.aws_ami.suse12.id}"
  instance_type          = "r4.4xlarge" #"m5.large"
  key_name               = "${aws_key_pair.sshkey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"
  user_data              = "${data.template_file.user_data.rendered}"

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_type           = "gp2"
    volume_size           = "27"
    delete_on_termination = true
  }

  ephemeral_block_device {
    virtual_name = "ephemeral0"
    device_name  = "/dev/sde"
    no_device    = false
  }

  tags {
    Terraformed = "true"
    Name        = "suse12"
  }

  volume_tags {
    Terraformed = "true"
    Name        = "suse12 volume root"
  }

  lifecycle {
    ignore_changes  = ["ami", "instance_type", "ebs_optimized", "volume_tags", "ebs_block_device"]
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
