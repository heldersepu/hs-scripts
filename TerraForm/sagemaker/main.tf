provider "aws" {
  region = "us-east-1"
}

# S3 bucket to store training data and output
resource "aws_s3_bucket" "sagemaker_bucket" {
  bucket = "your-sagemaker-bucket-name"
  acl    = "private"
}

# IAM role for SageMaker
resource "aws_iam_role" "sagemaker_role" {
  name = "sagemaker-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sagemaker.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM policy attachment for SageMaker role
resource "aws_iam_role_policy_attachment" "sagemaker_policy_attachment" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# SageMaker training job
resource "aws_sagemaker_training_job" "example" {
  name         = "example-training-job"
  role_arn     = aws_iam_role.sagemaker_role.arn
  algorithm_specification {
    training_image = "382416733822.dkr.ecr.us-west-2.amazonaws.com/linear-learner:latest"
    training_input_mode = "File"
  }

  input_data_config {
    channel_name = "train"
    data_source {
      s3_data_source {
        s3_data_type   = "S3Prefix"
        s3_uri         = "s3://${aws_s3_bucket.sagemaker_bucket.bucket}/train"
        s3_data_distribution_type = "FullyReplicated"
      }
    }
  }

  output_data_config {
    s3_output_path = "s3://${aws_s3_bucket.sagemaker_bucket.bucket}/output"
  }

  resource_config {
    instance_type   = "ml.m5.large"
    instance_count  = 1
    volume_size_in_gb = 10
  }

  stopping_condition {
    max_runtime_in_seconds = 3600
  }

  hyper_parameters = {
    "feature_dim" = "784"
    "mini_batch_size" = "100"
    "predictor_type" = "binary_classifier"
  }
}
