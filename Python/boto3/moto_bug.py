import boto3
from moto import mock_aws


@mock_aws
def test():
    ec2 = boto3.client("ec2", region_name="us-east-1")
    response = ec2.create_vpc(CidrBlock='10.0.0.0/16')
    response = ec2.create_subnet(CidrBlock='10.0.1.0/24', VpcId=response["Vpc"]["VpcId"])

    elbv2 = boto3.client('elbv2', region_name="us-east-1")
    response = elbv2.create_load_balancer(Name='test', Subnets=[response['Subnet']['SubnetId']])
    response = elbv2.create_listener(
        LoadBalancerArn=response['LoadBalancers'][0]['LoadBalancerArn'],
        Protocol='HTTPS',
        Port=443,
        SslPolicy='ELBSecurityPolicy-2016-08',
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
    response = elbv2.modify_listener(
        ListenerArn=response['Listeners'][0]['ListenerArn'],
        SslPolicy='ELBSecurityPolicy-FS-1-2-Res-2020-10'
    )
    print(response)

test()
#botocore.errorfactory.SSLPolicyNotFoundException: An error occurred (SSLPolicyNotFound) when calling the ModifyListener operation: Policy ELBSecurityPolicy-FS-1-2-Res-2020-10 not found