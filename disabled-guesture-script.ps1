# Run as Administrator

# Disable Edge Swipe Gestures (EdgeUI)
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "AllowEdgeSwipe" -Value 0 -PropertyType DWORD -Force | Out-Null

# Disable Help Tips (e.g., touch hints, UI tips)
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableHelpTips" -Value 1 -PropertyType DWORD -Force | Out-Null

# Optional: Apply to Current User as well
New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableHelpTips" -Value 1 -PropertyType DWORD -Force | Out-Null

# Restart the computer to apply changes
Restart-Computer -Force
