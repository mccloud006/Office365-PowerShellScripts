#set the location of the CSV file that has the user details
$path = "C:\o365\office365users.csv" 

#this sets the licence plan that we want to apply - use the command Get-MsolAccountSku to list the types of licences we have
$server = "homeofficegovuk:ENTERPRISEWITHSCAL" 
#Specify the plans that we want to disable on a user account. To see a list of planes a user has, paste this command into the console:
#Get-MsolUser -UserPrincipalName richard.ridder@digital.homeoffice.gov.uk | Select-Object -ExpandProperty Licenses | Select-Object -ExpandProperty ServiceStatus
$LO = New-MsolLicenseOptions -AccountSkuId "homeofficegovuk:ENTERPRISEWITHSCAL" -DisabledPlans "YAMMER_ENTERPRISE", "SWAY"

import-csv $path | foreach { 
Write-Host "Creating new account for:" $_.displayname
New-Msoluser -userPrincipalName $_.UserPrincipalName -displayname $_.displayname -firstname $_.firstname -lastname $_.lastname -password $_.Password -LicenseAssignment $server -LicenseOptions $LO -usagelocation "GB"#| set-msoluserlicense -addlicenses "$server"
Write-Host "Applying Mailbox features:"
#Enable or Disable OWA,IMAP, MAPI and POP3
Set-CASMailbox $_.UserPrincipalName -OWAEnabled $True -PopEnabled $False -MAPIEnabled $false -ImapEnabled $false -ActiveSyncEnabled $false
#Enforce MFA on user account

$mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = "*"
$mfa = @($mf)

Set-MsolUser -UserPrincipalName $_.UserPrincipalName -StrongAuthenticationRequirements $mfa
 

#Add user to the Home Office Digital group

$user = Get-Msoluser -UserPrincipalName $_.Userprincipalname | select Objectid 
Add-MsolGroupMember -groupObjectid ‘6d743fec-af0e-4c94-be4d-abfc603e852b’ -GroupMemberObjectId $user.ObjectId -GroupMemberType User

#Enable litigation holdget
Set-Mailbox $_.UserPrincipalName -LitigationHoldEnabled $true

#Send a welcome email to the user.

}

