import boto3

s3 = boto3.resource('s3')
bucket = s3.Bucket('test456345245')
bucket.object_versions.all().delete()
bucket.delete()