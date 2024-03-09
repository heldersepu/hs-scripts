import boto3
client = boto3.client('ec2')

def delete_flow_logs(flow_id):
    response = client.delete_flow_logs(FlowLogIds=[flow_id])
    if (response['Unsuccessful']):
        print(response['Unsuccessful'])

def create_flow_logs(vpc_id, s3_bucket_arn):
    response = client.describe_flow_logs(
        Filter=[{
            'Name': 'resource-id',
            'Values': [vpc_id]
        }]
    )
    create_flow_log = True
    for x in response['FlowLogs']:
        if (x['LogDestinationType'] == 's3' and x['LogDestination'] == s3_bucket_arn):
            print('Flow log already present')
            create_flow_log = False
            break

    if create_flow_log:
        response = client.create_flow_logs(
            ResourceIds=[vpc_id],
            ResourceType='VPC',
            TrafficType='ALL',
            LogDestinationType='s3',
            LogDestination=s3_bucket_arn,
            MaxAggregationInterval=600
        )
        if (response['Unsuccessful']):
            print(response['Unsuccessful'])

vpc_id = 'vpc-0627130d668a04f24'
s3_bucket_arn = 'arn:aws:s3:::testings3flowlogs'

# create_flow_logs(vpc_id, s3_bucket_arn)
# delete_flow_logs('fl-02e4e9fe3c6ce5b53')
