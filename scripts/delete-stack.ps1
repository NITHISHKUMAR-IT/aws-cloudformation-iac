param([string]$StackName = "nithish-cloudformation-web", [string]$Region = "ap-south-1")
$ErrorActionPreference = "Stop"
aws cloudformation delete-stack --stack-name $StackName --region $Region
if ($LASTEXITCODE -ne 0) { throw "Delete request failed." }
aws cloudformation wait stack-delete-complete --stack-name $StackName --region $Region
if ($LASTEXITCODE -ne 0) { throw "Stack deletion failed." }
Write-Host "Stack deleted successfully." -ForegroundColor Green
