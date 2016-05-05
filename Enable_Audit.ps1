#Enable Audit on all mailboxs within the @digital.homeoffice.gov.uk domain
$users = Get-MsolUser | Where-Object {$_.isLicensed -eq $true} #get a list of all users
$userCounter = 0


    foreach ($user in $users) 

    {

     If ($user.UserPrincipalName -like '*digital*')#if the user has a digitl email address
            {
            Write-Host "Enabling Auditing for  " $user.UserPrincipalName -foregroundcolor "Cyan"
            Set-Mailbox $user.UserPrincipalName -AuditEnabled $true
            $userCounter++
            }
    
    }
Write-Host "Accounts Auditing enabled for: " $userCounter -ForegroundColor "Magenta"
