# https://hub.docker.com/r/andyshinn/dnsmasq/~/dockerfile/

resource "aws_ecs_task_definition" "test" {
  family                   = "testscheduler"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "${aws_iam_role.role.arn}"
  task_role_arn            = "${aws_iam_role.role.arn}"

  container_definitions = <<DEFINITION
[
  {
    "name": "testscheduler",
    "essential": true,
    "image": "andyshinn/dnsmasq:latest",
    "command": ["--cap-add=NET_ADMIN", "--net=host"],
    "cpu": 256,
    "memory": 512,
    "networkMode": "awsvpc"
  }
]
DEFINITION
}

resource "aws_ecs_cluster" "test" {
  name = "aws_ecs_cluster"
}

resource "aws_ecs_service" "test" {
  name            = "aws_ecs_service"
  cluster         = "${aws_ecs_cluster.test.id}"
  task_definition = "${aws_ecs_task_definition.test.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"
  depends_on      = ["aws_iam_role.role"]

  network_configuration {
    #security_groups = ["${aws_security_group.allow_all.id}"]
    subnets          = ["${aws_subnet.app1.id}"]
    assign_public_ip = true
  }
}

data "aws_iam_policy_document" "role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "iam_role"
  assume_role_policy = "${data.aws_iam_policy_document.role.json}"
}
