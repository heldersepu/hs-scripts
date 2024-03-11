import boto3

def change_ssl_policy(elb_name,  ssl_policy):
    elb_client = boto3.client('elbv2')

    response = elb_client.describe_load_balancers(Names=[elb_name])
    response = elb_client.describe_listeners(
        LoadBalancerArn=response['LoadBalancers'][0]['LoadBalancerArn']
    )

    if (response['Listeners'][0]['SslPolicy'] != ssl_policy):
        elb_client.modify_listener(
            ListenerArn=response['Listeners'][0]['ListenerArn'],
            SslPolicy=ssl_policy
        )


elb_name= 'test'
ssl_policy = 'ELBSecurityPolicy-FS-1-2-Res-2020-10'

change_ssl_policy(elb_name, ssl_policy)
