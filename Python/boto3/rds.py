import boto3
from moto import mock_aws

@mock_aws
def rds():
    client = boto3.client("rds")
    response = client.create_db_instance(
        DBInstanceIdentifier="test",
        DBInstanceClass="db.m5.large",
        Engine="sqlserver-se",
        MasterUsername='string',
        MasterUserPassword='string123',
        LicenseModel="license-included",
        AllocatedStorage=32
    )
    print(response)
    print("---")

    response = client.modify_db_instance(
        DBInstanceIdentifier="test",
        CloudwatchLogsExportConfiguration={'EnableLogTypes':['error']}
    )
    print(response)
    print("---")

    response = client.describe_db_instances(DBInstanceIdentifier="test")
    print(response)
    print("---")

rds()
