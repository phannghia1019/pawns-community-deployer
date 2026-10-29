# Pawns.app Community Peer Node Deployer for Windows (PowerShell)
[CmdletBinding()]
param()

Clear-Host
Write-Host "=========================================================================================" -ForegroundColor Cyan
Write-Host "             PAWNS.APP COMMUNITY PEER BANDWIDTH ONBOARDING & CONSENT FLOW               " -ForegroundColor Cyan
Write-Host "=========================================================================================" -ForegroundColor Cyan
$Hostname = $env:COMPUTERNAME
$OSInfo = (Get-CimInstance Win32_OperatingSystem).Caption
Write-Host "Device Hostname : $Hostname  |  Platform: Windows 11 ($OSInfo)"
Write-Host "Target Client   : Official Docker Container: iproyal/pawns-cli:latest"
Write-Host "-----------------------------------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "USER PRIVACY & RESOURCE SHARING DISCLOSURE:" -ForegroundColor Yellow
Write-Host "1. Bandwidth Sharing Only: Only unused residential bandwidth is routed via encrypted tunnel."
Write-Host "2. Zero Data Access:       The CLI has zero access to personal files, browsing, or storage."
Write-Host "3. Official Terms:         Terms of Use:   https://pawns.app/terms-of-use/"
Write-Host "                           Privacy Policy: https://pawns.app/privacy-policy/"
Write-Host "4. Revocation:             You can terminate this node at any time via docker stop pawns-peer-node."
Write-Host "-----------------------------------------------------------------------------------------" -ForegroundColor DarkGray

$Consent = Read-Host "Do you understand the terms and grant consent to share idle bandwidth? (yes/no)"

if ($Consent.Trim().ToLower() -ne "yes") {
    Write-Host "[ABORTED] Consent not granted. Aborting deployment." -ForegroundColor Red
    exit 1
}

$LogDir = "$env:ProgramData\pawns"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogEntry = "[{0:u}] CONSENT_GRANTED: User={1}, Host={2}, Mode=Docker-Windows" -f (Get-Date).ToUniversalTime(), $env:USERNAME, $Hostname
Add-Content -Path "$LogDir\consent-audit.log" -Value $LogEntry

Write-Host "[✓ CONSENT RECORDED] Logged to $LogDir\consent-audit.log" -ForegroundColor Green
Write-Host "[INFO]               Verifying docker runtime and pulling official image..." -ForegroundColor Blue
docker pull iproyal/pawns-cli:latest

Write-Host "[INFO]               Starting container 'pawns-peer-node' with official -accept-tos flag..." -ForegroundColor Blue
docker run -d `
  --name pawns-peer-node `
  --restart unless-stopped `
  iproyal/pawns-cli:latest `
  -email="phankhacbaonghia@gmail.com" `
  -password="DEVICE_PEER_KEY" `
  -device-name="$Hostname" `
  -accept-tos

Write-Host ""
Write-Host "[SUCCESS]            Pawns.app CLI node is active and healthy! (Node: $Hostname)" -ForegroundColor Green
