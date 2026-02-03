# AWS ETL Pipeline (Glue + Step Functions + Lambda)

## Project Overview
This project implements a **fully automated end-to-end ETL pipeline on AWS** using **PySpark and serverless AWS services**.  
All infrastructure and resources are provisioned using **AWS CLI**, without manual configuration through the AWS Console.

The pipeline ingests raw data into Amazon S3, processes it using **two AWS Glue PySpark jobs**, orchestrates execution using **AWS Step Functions**, and sends a final pipeline status notification via **AWS Lambda and Amazon SES**.

---

## Architecture Flow
Local CSV
↓
Amazon S3 (raw)
↓
Glue Job 1 – Data Cleaning
↓
Amazon S3 (processed)
↓
Glue Job 2 – Data Aggregation
↓
Amazon S3 (curated - Parquet)
↓
AWS Step Functions
↓
AWS Lambda
↓
Amazon SES (Email Notification)


---

## Technologies Used
- Amazon S3
- AWS Glue (PySpark)
- AWS Step Functions
- AWS Lambda
- Amazon SES
- AWS IAM
- AWS CLI
- Python / PySpark

---

etl_aws_final_project/
│
├── glue_jobs/
│ ├── job1_cleaning.py
│ └── job2_aggregation.py
│
├── lambda/
│ └── email_lambda.py
│
├── step_functions/
│ └── state_machine.json
│
├── iam/
│ ├── glue_trust.json
│ ├── glue_permissions.json
│ ├── lambda_trust.json
│ ├── lambda_permissions.json
│ ├── stepfn_trust.json
│ └── stepfn_permissions.json
│
├── cli/
│ ├── 01_create_s3.sh
│ ├── 02_create_iam.sh
│ ├── 03_create_lambda.sh
│ ├── 04_create_glue_jobs.sh
│ └── 05_create_stepfn.sh
│
├── data/
│ └── sales.csv
│
└── README.md




![Untitled Diagram](https://github.com/user-attachments/assets/3ce784f1-a492-4ca9-96d2-0415865c6755)



---






## ETL Pipeline Details

### Glue Job 1 – Data Cleaning
- Reads raw CSV data from the S3 raw bucket
- Removes null values
- Removes duplicate records
- Writes cleaned data to the S3 processed bucket in Parquet format

### Glue Job 2 – Data Aggregation
- Reads cleaned data from the S3 processed bucket
- Creates a derived column (`total_amount`)
- Writes analytics-ready data to the S3 curated bucket in Parquet format

---

## Orchestration and Notifications

### AWS Step Functions
- Orchestrates the complete ETL workflow
- Executes Glue Job 1 followed by Glue Job 2
- Determines overall pipeline success or failure

### AWS Lambda + Amazon SES
- Lambda is triggered **only after the entire pipeline completes**
- Sends a single email notification indicating pipeline status
- Amazon SES is used to deliver the email

---

## Infrastructure Provisioning
- All AWS resources are created using **AWS CLI**
- No manual resource creation via AWS Console
- IAM roles are defined using:
  - Trust policies (who can assume the role)
  - Permission policies (what actions are allowed)

Resources created:
- Amazon S3 bucket
- IAM roles and policies
- AWS Glue jobs
- AWS Lambda function
- AWS Step Functions state machine

---

## How to Run the Project


```bash
Step 1: Configure AWS CLI
aws configure

Step 2: Create S3 Bucket
cd cli
bash 01_create_s3.sh

Step 3: Upload Input Data
aws s3 cp ../data/sales.csv s3://etl-ap-south-1/raw/

Step 4: Create IAM Roles
bash 02_create_iam.sh

Step 5: Create Lambda Function
bash 03_create_lambda.sh
Note: Sender email must be verified in Amazon SES.

Step 6: Upload Glue Scripts
aws s3 cp ../glue_jobs/job1_cleaning.py s3://etl-ap-south-1/scripts/
aws s3 cp ../glue_jobs/job2_aggregation.py s3://etl-ap-south-1/scripts/

Step 7: Create Glue Jobs
bash 04_create_glue_jobs.sh

Step 8: Create Step Function
bash 05_create_stepfn.sh

aws stepfunctions start-execution \
--state-machine-arn arn:aws:states:ap-south-1:613058600446:stateMachine:etl-stepfn \
--region ap-south-1

Output Verification
Check curated data in S3:

aws s3 ls s3://etl-ap-south-1/curated/
Check Glue job execution:

aws glue get-job-runs --job-name etl-job-cleaning

