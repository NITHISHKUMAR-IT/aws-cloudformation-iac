param(
  [string]$StackName = "nithish-cloudformation-web",
  [string]$Region = "ap-south-1",
  [string]$ProjectName = "nithish-cloudformation-web",
  [ValidateSet("dev","test","prod")][string]$Environment = "dev",
  [ValidateSet("t3.micro","t3.small")][string]$InstanceType = "t3.micro"
)
$ErrorActionPreference = "Stop"
aws cloudformation deploy `
  --template-file template.yaml `
  --stack-name $StackName `
  --region $Region `
  --capabilities CAPABILITY_NAMED_IAM `
  --parameter-overrides ProjectName=$ProjectName Environment=$Environment InstanceType=$InstanceType `
  --tags Project=$ProjectName Environment=$Environment ManagedBy=CloudFormation
if ($LASTEXITCODE -ne 0) { throw "Stack deployment failed." }
aws cloudformation describe-stacks --stack-name $StackName --region $Region --query "Stacks[0].Outputs" --output table
