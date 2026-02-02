import boto3

def lambda_handler(event, context):
    ses = boto3.client("ses")
    ses.send_email(
        Source="tanmayhiwanj2003@gmail.com.com",
        Destination={"ToAddresses": ["tanmayhiwanj80@gmail.com"]},
        Message={
            "Subject": {"Data": "ETL Pipeline Status"},
            "Body": {"Text": {"Data": "ETL pipeline executed successfully."}}
        }
    )
    return {"status": "success"}
