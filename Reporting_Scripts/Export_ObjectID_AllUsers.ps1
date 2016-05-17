#Export the ObjectId for all users to a .CSV

$sub = Import-Csv C:\o365\user.csv 
$sub | Foreach {Get-Msoluser -UserPrincipalName $_.Userprincipalname | select Objectid } | Export-csv C:\o365\Users2.csv 
