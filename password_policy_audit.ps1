# Get password policy settings
$passwordPolicy = Get-LocalUser | Where-Object { $_.PasswordRequired -eq $true }

# Display password policy information
Write-Output "Password Policy Audit:"
foreach ($user in $passwordPolicy) {
    Write-Output "User: $($user.Name)"
    Write-Output "Password Last Set: $($user.PasswordLastSet)"
    Write-Output "Password Expires: $($user.PasswordExpires)"
    Write-Output "Account Locked: $($user.Lockout)}"
    Write-Output ""
}

# Get system-wide password policies
$passwordPolicies = Get-LocalGroupPolicySetting -Name "Password Policy"

Write-Output "System Password Policy Settings:"
Write-Output "Minimum Password Length: $($passwordPolicies.'Minimum Password Length')"
Write-Output "Password History Size: $($passwordPolicies.'Enforce Password History')"
Write-Output "Maximum Password Age: $($passwordPolicies.'Maximum Password Age')"
Write-Output "Minimum Password Age: $($passwordPolicies.'Minimum Password Age')"
Write-Output "Complexity Requirements: $($passwordPolicies.'Password Must Meet Complexity Requirements')"
