import boto3
from moto import mock_aws

@mock_aws
def create_resources():
    ec2_client = boto3.client('ec2', region_name="us-east-1")
    elbv2_client = boto3.client('elbv2', region_name="us-east-1")

    vpc_response = ec2_client.create_vpc(
        CidrBlock='10.0.0.0/16',
        AmazonProvidedIpv6CidrBlock=False
    )
    vpc_id = vpc_response['Vpc']['VpcId']

    subnet_response = ec2_client.create_subnet(
        CidrBlock='10.0.1.0/24',
        VpcId=vpc_id
    )
    subnet_id = subnet_response['Subnet']['SubnetId']
    print(subnet_id)
    alb_response = elbv2_client.create_load_balancer(
        Name='my-load-balancer',
        Subnets=[subnet_id]
    )
    alb_arn = alb_response['LoadBalancers'][0]['LoadBalancerArn']
    print(alb_arn)

    response = elbv2_client.create_listener(
        LoadBalancerArn=alb_arn,
        Protocol='HTTPS',
        Port=443,
        DefaultActions=[
            {
                'Type': 'redirect',
                'RedirectConfig': {
                    'Port': '80',
                    'Protocol': 'HTTPS',
                    'StatusCode': 'HTTP_301'
                }
            }
        ]
    )
    listener = response['Listeners'][0]
    print(listener['ListenerArn'])
    print(listener['SslPolicy'])

create_resources()
