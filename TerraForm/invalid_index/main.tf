resource "aws_cloudformation_stack" "cf" {
  name          = "cf"
  template_body = <<STACK
{
  "Resources": {
    "myVpc": {
      "Type": "AWS::EC2::VPC",
      "Properties": { "CidrBlock": "10.0.0.0/16" }
    }
  },
  "Outputs": {
    "vpc": { "Value": {"Ref": "myVpc"} }
  }
}
STACK
}

resource "aws_key_pair" "sshkey" {
  key_name   = aws_cloudformation_stack.cf.outputs["vpc"]
  public_key = file("~/Downloads/AWS_keys/test.pem.pub")
}