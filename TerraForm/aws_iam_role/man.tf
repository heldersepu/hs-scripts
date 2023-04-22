resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_123"

  assume_role_policy = jsonencode({
        Version: "2012-10-17",
        Statement: [
            {
                Action: "sts:AssumeRole",
                Principal: {
                    Service: "lambda.amazonaws.com"
                },
                Effect: "Allow",
                Sid: ""
            }
        ]
    })
}
