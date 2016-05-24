# Report on userrs who hve MFA in disabled status excluding those who are blocked
# Requires you to be connected to Azure and MSOL
# Still inlcudes external users, but can be filtered out in Excel

Get-MsolUser | Where-Object {[string]::IsNullOrEmpty($_.StrongAuthenticationRequirements) -and $_.BlockCredential -eq $False } | select UserPrincipalName


