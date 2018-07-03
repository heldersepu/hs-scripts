data "aws_ami" "suse12" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse*12-*"]
  }

  filter {
    name   = "image-id"
    values = ["ami-1c761163"] #["ami-388f9642"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami" "win2016" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-2018.06.13*"]
  }

  filter {
    name   = "image-id"
    values = ["ami-0327667c"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
