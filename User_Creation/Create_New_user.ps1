#set the location of the CSV file that has the user details
$path = "C:\o365\office365users.csv" 

#this sets the licence plan that we want to apply - use the command Get-MsolAccountSku to list the types of licences we have
$server = "homeofficegovuk:ENTERPRISEWITHSCAL" 
#Specify the plans that we want to disable on a user account. To see a list of planes a user has, paste this command into the console:
#Get-MsolUser -UserPrincipalName richard.ridder@digital.homeoffice.gov.uk | Select-Object -ExpandProperty Licenses | Select-Object -ExpandProperty ServiceStatus
$LO = New-MsolLicenseOptions -AccountSkuId "homeofficegovuk:ENTERPRISEWITHSCAL" -DisabledPlans "YAMMER_ENTERPRISE", "SWAY"

import-csv $path | foreach { 
Write-Host "Creating new account for:" $_.displayname
New-Msoluser -UserPrincipalName $_.UserPrincipalName -Displayname $_.displayname -Firstname $_.firstname -Lastname $_.lastname -Password $_.Password -LicenseAssignment $server -LicenseOptions $LO -usagelocation "GB"#| set-msoluserlicense -addlicenses "$server"

Start-Sleep -s 60

Write-Host "Applying Mailbox features:"

#Enable or Disable OWA,IMAP, MAPI and POP3
Set-CASMailbox $_.UserPrincipalName -OWAEnabled $True -PopEnabled $False -MAPIEnabled $false -ImapEnabled $false -ActiveSyncEnabled $false

# Set-Mailbox -Identity $_.UserPrincipalName -AuditEnabled $true (Copy until tested, enables auditing as per pen test requirement)

Start-Sleep -s 10
#Enforce MFA on user account

$mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = "*"
$mfa = @($mf)

Set-MsolUser -UserPrincipalName $_.UserPrincipalName -StrongAuthenticationRequirements $mfa
 

Start-Sleep -s 10
#Add user to the Home Office Digital group (revised approch by DE to add to the MailEnabledSecurityGroup)

$user = Get-Msoluser -UserPrincipalName $_.Userprincipalname | select Objectid 
Add-DistributionGroupMember -Identity "HomeOfficeDigital" -Member $user -BypassSecurityGroupManagerCheck


#Enable litigation hold
Set-Mailbox $_.UserPrincipalName -LitigationHoldEnabled $true

#Send a welcome email to the user.

}

