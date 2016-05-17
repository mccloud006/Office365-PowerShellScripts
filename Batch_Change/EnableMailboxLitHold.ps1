#Enable litigation hold on all mailboxs within the @digital.homeoffice.gov.uk domain
$users = Get-MsolUser | Where-Object {$_.isLicensed -eq $true} #get a list of all users
$userCounter = 0


    foreach ($user in $users) 

    {

     If ($user.UserPrincipalName -like '*digital*')#if the user has a digitl email address
            {
            Write-Host "Enabling Litigation Hold for  " $user.UserPrincipalName -foregroundcolor "Cyan"
            Set-Mailbox $user.UserPrincipalName -LitigationHoldEnabled $true #-whatif #Enable the full litigation hold - remove -whatif to activate
            $userCounter++
            }
    
    }
Write-Host "Accounts litigation hold enabled for: " $userCounter -ForegroundColor "Magenta"

