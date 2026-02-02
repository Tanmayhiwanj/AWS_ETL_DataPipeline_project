aws iam create-role --role-name ETLGlueRole --assume-role-policy-document file://iam/glue_trust.json
aws iam put-role-policy --role-name ETLGlueRole --policy-name GluePermissions --policy-document file://iam/glue_permissions.json

aws iam create-role --role-name ETLLambdaRole --assume-role-policy-document file://iam/lambda_trust.json
aws iam put-role-policy --role-name ETLLambdaRole --policy-name LambdaPermissions --policy-document file://iam/lambda_permissions.json

aws iam create-role --role-name ETLStepFunctionRole --assume-role-policy-document file://iam/stepfn_trust.json
aws iam put-role-policy --role-name ETLStepFunctionRole --policy-name StepFnPermissions --policy-document file://iam/stepfn_permissions.json
