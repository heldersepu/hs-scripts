import boto3

def change_ssl_policy(elb_name,  ssl_policy):
    elb_client = boto3.client('elbv2')

    response = elb_client.describe_load_balancers(Names=[elb_name])
    response = elb_client.describe_listeners(
        LoadBalancerArn=response['LoadBalancers'][0]['LoadBalancerArn']
    )

    for listener in response['Listeners']:
        if (listener['Protocol'] in ["HTTPS", "TLS"] and listener['SslPolicy'] != ssl_policy):
            elb_client.modify_listener(
                ListenerArn=listener['ListenerArn'],
                SslPolicy=ssl_policy
            )


elb_name= 'test'
ssl_policy = 'ELBSecurityPolicy-FS-1-2-Res-2020-10'

change_ssl_policy(elb_name, ssl_policy)
