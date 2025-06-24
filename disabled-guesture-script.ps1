# Make sure this is run as Administrator

Write-Host "📋 Starting script to disable swipe gestures and help tips..." -ForegroundColor Cyan

# Step 1: Store current execution policy and set to Bypass temporarily
$originalPolicy = Get-ExecutionPolicy
Write-Host "🔧 Current Execution Policy: $originalPolicy"
Write-Host "🛡️  Temporarily setting Execution Policy to 'Bypass'..."
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Step 2: Disable Edge Swipe gestures
Write-Host "🚫 Disabling Edge Swipe gestures..."
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force | Out-Null
}
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" `
    -Name "AllowEdgeSwipe" -PropertyType DWORD -Value 0 -Force | Out-Null
Write-Host "✅ Edge Swipe disabled."

# Step 3: Disable Help Tips (system-wide)
Write-Host "🚫 Disabling Help Tips for all users..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" `
    -Name "DisableHelpTips" -PropertyType DWORD -Value 1 -Force | Out-Null
Write-Host "✅ Help Tips disabled for all users."

# Step 4: Disable Help Tips for current user
Write-Host "👤 Disabling Help Tips for current user..."
if (-not (Test-Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI")) {
    New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Force | Out-Null
}
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" `
    -Name "DisableHelpTips" -PropertyType DWORD -Value 1 -Force | Out-Null
Write-Host "✅ Help Tips disabled for current user."

# Step 5: Restore original execution policy (optional)
Write-Host "♻️  Restoring original execution policy: $originalPolicy"
Set-ExecutionPolicy -ExecutionPolicy $originalPolicy -Scope Process -Force

# Step 6: Restart computer
Write-Host "🔄 Restarting computer in 10 seconds to apply changes..."
Start-Sleep -Seconds 10
Restart-Computer -Force
