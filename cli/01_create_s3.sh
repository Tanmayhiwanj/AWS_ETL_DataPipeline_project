aws s3 mb s3://etl-ap-south-1 --region ap-south-1

aws s3api put-object --bucket etl-ap-south-1 --key raw/
aws s3api put-object --bucket etl-ap-south-1 --key processed/
aws s3api put-object --bucket etl-ap-south-1 --key curated/
aws s3api put-object --bucket etl-ap-south-1 --key scripts/
