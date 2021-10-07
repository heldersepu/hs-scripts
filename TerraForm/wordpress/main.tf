module "wordpress" {
  source = "git::https://github.com/heldersepu/terraform-aws-wordpress.git?ref=master"

  subnet_id = "subnet-c24689a5"
  subnet_2_id = "subnet-29a12a63"
  jumpbox_ip = "104.0.169.33/32"
  db_password = "380cccf909"
  ec2_public_key  = file("~/.ssh/wordpress.pub")
  ec2_private_key = file("~/.ssh/wordpress")
}