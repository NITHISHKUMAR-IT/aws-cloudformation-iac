param([string]$Region = "ap-south-1")
$ErrorActionPreference = "Stop"
Write-Host "Validating template..." -ForegroundColor Cyan
aws cloudformation validate-template --template-body file://template.yaml --region $Region
if ($LASTEXITCODE -ne 0) { throw "Template validation failed." }
Write-Host "Template validation completed successfully." -ForegroundColor Green
