#Make all users with  @digital.homeoffice.gov.uk domain email become members of the Mail Enabled Distribution list "Home Office Digital" 

$users = Get-MsolUser | Where-Object {$_.isLicensed -eq $true} #get a list of all users
$userCounter = 0


    foreach ($user in $users) 

    {

     If ($user.UserPrincipalName -like '*digital*')#if the user has a digitl email address
            {
            Write-Host "Welcome to Home Office Digital " $user.UserPrincipalName -foregroundcolor "Cyan"
            Add-DistributionGroupMember -Identity "HomeOfficeDigital" -Member $user.UserPrincipalName -BypassSecurityGroupManagerCheck
            $userCounter++
            }
    
    }
Write-Host "Accounts Auditing enabled for: " $userCounter -ForegroundColor "Magenta"
