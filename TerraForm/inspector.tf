resource "aws_inspector_resource_group" "scheduled_inspector" {
  tags = {
    Inspector   = "True"
    Terraformed = "true"
  }
}

resource "aws_inspector_assessment_target" "scheduled_inspector_target" {
  name               = "Scheduled assessment target"
  resource_group_arn = aws_inspector_resource_group.scheduled_inspector.arn
}
