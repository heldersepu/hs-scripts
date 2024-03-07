import boto3

ec2_client = boto3.client('ec2')
response = ec2_client.describe_vpcs()
for vpc in response['Vpcs']:
    print("VPC ID:", vpc['VpcId'])

    subnets_response = ec2_client.describe_subnets(Filters=[{'Name': 'vpc-id', 'Values': [vpc['VpcId']]}])
    for subnet in subnets_response['Subnets']:
        print("  Subnet ID:", subnet['SubnetId'])
        print("  CIDR:", vpc['CidrBlock'])
