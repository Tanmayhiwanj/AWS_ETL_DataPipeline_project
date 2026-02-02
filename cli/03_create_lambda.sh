zip lambda.zip lambda/email_lambda.py

aws lambda create-function --function-name etl-email-lambda --runtime python3.9 --handler email_lambda.lambda_handler --zip-file fileb://lambda.zip --role arn:aws:iam::613058600446:role/ETLLambdaRole --region ap-south-1
