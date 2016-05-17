#Get-Mailbox -ResultSize unlimited -Filter {recipientTypeDetails -eq "usermailbox"}|FL Name,Audit* |out-file c:\o365\Audit.Txt

#Generate a HTML list of usernames and if AuditEnabled or LitigationHold is enabled - this can be saved to a sharepoint folder to
#automaticly update a page on sites
#Get-Mailbox | Select-Object UserPrincipalName,AuditEnabled,LitigationHoldEnabled| ConvertTo-Html | Out-File C:\O365\audit.html

#Create a Object and add the output from multiple cmdlts and export full details to a .CSV file
#export a "Failure List" to a HTML file



$path = "C:\o365\Audit_Output.csv" # Path to where the .CSV file will be saved
$Results = @() #create a object for the results of the audit
$users = Get-MsolUser | Where-Object {$_.isLicensed -eq $true} #get a list of all users
$counter = 0
foreach($user in $users){
$UPN = $user.UserPrincipalName
$mbox = Get-Mailbox $UPN
$cbox = Get-CASMailbox $UPN
$max = 5 #variable for how many times for the loop to run

$properties = @{
User = $upn
First = $user.FirstName
Last = $user.LastName
MFA = $user.StrongAuthenticationRequirements.state
AuditEnabled =$mbox.auditenabled
LitigationHoldEnabled = $mbox.LitigationHoldEnabled
OWA_Enabled = $cbox.OWAEnabled
POP_Enabled = $cbox.PopEnabled
MAPI_enabled =$cbox.MAPIEnabled
IMAP_enabled =$cbox.ImapEnabled
ActiveSync_Enabled =$cbox.ActiveSyncEnabled


}
$counter++
write-host $counter
$Results += New-Object psobject -Property $properties
#Breaks the loop after a set amount of loops - usefull for testing changes
#If($counter -gt $max){break}

}
$Results |Select-Object User,First,Last,AuditEnabled,LitigationHoldEnabled,MFA,OWA_Enabled,POP_enabled,MAPI_Enabled,Imap_enabled,ActiveSync_enabled |Export-Csv -NoTypeInformation -Path $path