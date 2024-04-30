variable "aws_region" {
  default = "us-west-2"
}

variable "aws_account_id" {
  default = "621655500763"
}

variable "trail_name" {
  default = "testingtrail"
}

variable "bucket_name" {
  default = "thisisatestbucketname456790"
}

variable "organization_id" {
  default = "abc123"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_kms_key" "cloudtrail_kms_key" {
  description         = "KMS key for Cloudtrail S3 Bucket"
  enable_key_rotation = true
  multi_region        = true
}

resource "aws_kms_key_policy" "cloudtrail_kms_key_policy" {
  key_id = aws_kms_key.cloudtrail_kms_key.key_id
  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "cloudtrail-kms-key-policy",
    Statement : [
      {
        Sid       = "Enable IAM User Permissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${var.aws_account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        Sid    = "Permitted KMS Key Services"
        Effect = "Allow"
        Principal = {
          Service = ["cloudtrail.amazonaws.com"]
        }
        Action   = ["kms:GenerateDataKey*", "kms:DescribeKey", "kms:Decrypt"]
        Resource = "*",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceArn" : "arn:aws:cloudtrail:${var.aws_region}:${var.aws_account_id}:trail/${var.trail_name}"
          },
          "StringLike" : {
            "kms:EncryptionContext:aws:cloudtrail:arn" : "arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"
          }
        }
      }
    ]
  })
}

resource "aws_cloudtrail" "trail" {
  depends_on                 = [aws_s3_bucket_policy.cloudtrail_bucket_policy]
  name                       = var.trail_name
  s3_bucket_name             = aws_s3_bucket.cloudtrail_bucket.id
  is_organization_trail      = false
  is_multi_region_trail      = true
  kms_key_id                 = aws_kms_key.cloudtrail_kms_key.arn
  enable_log_file_validation = true
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "cloudtrail_bucket_ownership_controls" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

#Link to IAM policy : https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html#org-trail-bucket-policy
data "aws_iam_policy_document" "cloudtrail_bucket_policy" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail_bucket.arn]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:${var.aws_region}:${var.aws_account_id}:trail/${var.trail_name}"]
    }
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail_bucket.arn}/prefix/AWSLogs/${var.aws_account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:${var.aws_region}:${var.aws_account_id}:trail/${var.trail_name}"]
    }
  }

  statement {
    sid    = "AllowOrganizationTrailToPutObjects"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail_bucket.arn}/prefix/AWSLogs/${var.organization_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:${var.aws_region}:${var.aws_account_id}:trail/${var.trail_name}"]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = data.aws_iam_policy_document.cloudtrail_bucket_policy.json
}
