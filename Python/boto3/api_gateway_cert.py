import boto3
from datetime import datetime, timedelta


def create():
    client = boto3.client('apigateway')
    response = client.get_client_certificates(limit=5)
    cert_id = ""
    for certificate in response['items']:
        future = datetime.now(certificate["expirationDate"].tzinfo)- timedelta(days=30)
        if "test_cert" in certificate.get('description', '') and certificate["expirationDate"] > future:
            print(certificate)
            cert_id = certificate["clientCertificateId"]
    if cert_id == "":
        response = client.generate_client_certificate(description="test_cert")
        print(response)



create()