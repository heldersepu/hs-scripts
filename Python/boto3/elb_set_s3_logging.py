import boto3

def set_s3_logging(elb_name,  bucket_name):
    elb_client = boto3.client('elbv2')

    response = elb_client.describe_load_balancers(Names=[elb_name])
    response = elb_client.describe_load_balancer_attributes(
      LoadBalancerArn=response['LoadBalancers'][0]['LoadBalancerArn']
    )

    response = elb_client.modify_load_balancer_attributes(
        LoadBalancerArn=response['LoadBalancers'][0]['LoadBalancerArn'],
        Attributes=[
            {
                'Key': 'access_logs.s3.enabled',
                'Value': 'true'
            },
            {
                'Key': 'access_logs.s3.bucket',
                'Value': bucket_name
            }
        ]
    )


elb_name= 'test'
bucket_name = 'test456345245'

set_s3_logging(elb_name, bucket_name)
