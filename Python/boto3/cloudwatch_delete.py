import boto3

def logs_delete(keyword):
    client = boto3.client('logs')

    paginator = client.get_paginator('describe_log_groups')
    for response in paginator.paginate():
        for log_group in response['logGroups']:
            if log_group['logGroupName'].startswith(keyword):
                client.delete_log_group(logGroupName=log_group['logGroupName'])
                print(log_group['logGroupName'])

logs_delete('test')
