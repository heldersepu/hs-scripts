provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudformation_stack" "cmk_key" {
  name          = "cmk-key-stack"
  template_body = <<EOT
  Resources:
    Key:
      Type: AWS::KMS::Key
      Properties:
        Enabled: true
        MultiRegion: true
        KeyPolicy:
          Version: "2012-10-17"
          Statement:
            - Sid: "Enable IAM User Permissions"
              Effect: "Allow"
              Principal:
                AWS:
                  Fn::Join:
                    - ""
                    -
                      - "arn:aws:iam::"
                      - Ref: "AWS::AccountId"
                      - ":root"
              Action: "kms:*"
              Resource: "*"
    Alias:
      Type: AWS::KMS::Alias
      Properties:
        AliasName: "alias/dev/cmk-key"
        TargetKeyId: !Ref Key
EOT
}