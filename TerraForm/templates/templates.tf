data "template_file" "user_data1" {
  template = file("${path.module}/bootstrap.sh")

  vars {
    hostname = "00"
  }
}

data "template_file" "user_data2" {
  count    = 2
  template = file("${path.module}/bootstrap.sh")

  vars {
    hostname = "1${count.index}"
  }
}
