# Run this script as Administrator

Write-Host "📋 Starting script to disable swipe gestures and help tips..." -ForegroundColor Cyan

# Step 1: Store current execution policy and set to Bypass temporarily
$originalPolicy = Get-ExecutionPolicy
Write-Host "🔧 Current Execution Policy: $originalPolicy"
Write-Host "🛡️  Temporarily setting Execution Policy to 'Bypass'..."
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Step 2: Disable Edge Swipe
Write-Host "🚫 Disabling Edge Swipe gestures..."
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "AllowEdgeSwipe" -Value 0 -PropertyType DWORD -Force | Out-Null
Write-Host "✅ Edge Swipe disabled."

# Step 3: Disable Help Tips
Write-Host "🚫 Disabling Help Tips (touch hints)..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableHelpTips" -Value 1 -PropertyType DWORD -Force | Out-Null
Write-Host "✅ Help Tips disabled for all users."

# Step 4: Apply Help Tips policy for current user too
Write-Host "👤 Disabling Help Tips for current user..."
New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableHelpTips" -Value 1 -PropertyType DWORD -Force | Out-Null
Write-Host "✅ Help Tips disabled for current user."

# Step 5: Restore Execution Policy (Optional, just for good practice)
Write-Host "♻️  Restoring original execution policy: $originalPolicy"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy $originalPolicy -Force

# Step 6: Restart
Write-Host "🔄 Restarting computer in 10 seconds to apply changes..."
Start-Sleep -Seconds 10
Restart-Computer -Force
