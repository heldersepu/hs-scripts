`aws apigateway get-stages --rest-api-id lk4x1zvweh`

```
{
    "item": [
        {
            "deploymentId": "g7hyk5",
            "stageName": "test",
            "cacheClusterEnabled": false,
            "cacheClusterStatus": "NOT_AVAILABLE",
            "methodSettings": {},
            "accessLogSettings": {
                "format": "{ \"requestId\":\"$context.requestId\" }",
                "destinationArn": "arn:aws:logs:us-east-1:621655500763:log-group:/aws/api_gateway/test"
            },
            "tracingEnabled": false,
            "createdDate": "2023-06-24T03:20:35+00:00",
            "lastUpdatedDate": "2023-06-24T03:20:35+00:00"
        }
}
```