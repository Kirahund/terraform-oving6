$ErrorActionPreference = "Stop"

Set-Location "$PSScriptRoot\modules\network"

function Test-Command {
    param(
        [string]$Name,
        [scriptblock]$Command
    )

    Write-Host "`nKjører $Name..." -ForegroundColor Cyan

    & $Command

    if ($LASTEXITCODE -ne 0) {
        Write-Host "$Name FEILET!" -ForegroundColor Red
        exit 1
    }

    Write-Host "$Name OK" -ForegroundColor Green
}

Test-Command "Terraform fmt" {
    terraform fmt -check -recursive
}

Test-Command "Terraform validate" {
    terraform validate
}

Test-Command "TFLint" {
    tflint
}
Test-Command "Checkov" {
    & "$env:LOCALAPPDATA\Programs\Python\Python312\python.exe" -m checkov.main -d . --config-file .checkov.yaml
}


Test-Command "Terraform test" {
    terraform test
}

Write-Host "`nAlle kontroller bestått!" -ForegroundColor Green