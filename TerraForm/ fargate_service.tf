# https://hub.docker.com/r/andyshinn/dnsmasq/~/dockerfile/

resource "aws_ecs_task_definition" "test" {
  family                   = "testscheduler"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "${aws_iam_role.iam_role.arn}"
  task_role_arn            = "${aws_iam_role.iam_role.arn}"

  container_definitions = <<DEFINITION
[
  {
    "name": "testscheduler",
    "essential": true,
    "image": "${var.image_address}",
    "cpu": 256,
    "memory": 512,
    "networkMode": "awsvpc",
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

  network_configuration {
    security_groups = ["${aws_security_group.allow_all.id}"]
    subnets         = ["${aws_subnet.app1.id}"]
  }
}