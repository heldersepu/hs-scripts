import boto3
import os


dynamodb = boto3.resource('dynamodb', region_name='us-east-1')

def lambda_handler(event, context):
    try:
        table_name = os.environ["TABLE_NAME"]

        item = {
            'UserID': 1,
            'PostID': 1,
            'content': 'Yay!',
        }
        table = dynamodb.Table(table_name)
        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': 'Item added to DynamoDB successfully',
        }
    except Exception as e:
        print('Error adding item to DynamoDB:', e)

        return {
            'statusCode': 500,
            'body': 'Error adding item to DynamoDB',
        }