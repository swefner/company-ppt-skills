$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$certificateRoot = Join-Path $env:USERPROFILE ".office-addin-dev-certs"

Push-Location $projectRoot
try {
    node scripts/generate-certs.mjs
    certutil.exe -user -addstore -f Root (Join-Path $certificateRoot "ca.crt") | Out-Null
    CheckNetIsolation.exe LoopbackExempt -a -n="microsoft.win32webviewhost_cw5n1h2txyewy" | Out-Null
    npx.cmd office-addin-dev-settings register manifest.xml
    Write-Output "PPT Skill Bridge local prerequisites are ready."
}
finally {
    Pop-Location
}
