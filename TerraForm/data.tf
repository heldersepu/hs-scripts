data "aws_ami" "suse12" {
  #ami-316d094e
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["suse-sles-sap-12-sp3-byos-v20180523*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami" "win2016" {
  #ami-0327667c
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-2018.06.13*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
