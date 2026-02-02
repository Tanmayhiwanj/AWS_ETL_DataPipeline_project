aws glue create-job --name etl-job-cleaning --role ETLGlueRole --command Name=glueetl,ScriptLocation=s3://etl-ap-south-1/scripts/job1_cleaning.py --glue-version 4.0 --worker-type G.1X --number-of-workers 2 --region ap-south-1

aws glue create-job --name etl-job-aggregation --role ETLGlueRole --command Name=glueetl,ScriptLocation=s3://etl-ap-south-1/scripts/job2_aggregation.py --glue-version 4.0 --worker-type G.1X --number-of-workers 2 --region ap-south-1
