
# Enable to generate .csv
Get-CASMailbox -ResultSize Unlimited |Select Name,ActiveSyncEnabled,OWAEnabled,PopEnabled,ImapEnabled,MapiEnabled |Export-CSV "C:\o365\Mail_Enabled.csv"

# Enable to generate HTML report
#Get-CASMailbox *@digital.homeoffice.gov.uk -ResultSize Unlimited |Select Name,ActiveSyncEnabled,OWAEnabled,PopEnabled,ImapEnabled,MapiEnabled |ConvertTo-Html -As Table | Out-File mail_enabled.html

#Invoke-Item mail_enabled.html 

#Import-Module MSOnline

$head = @"
<!DOCTYPE HTML PUBLIC  HTML 4.01 Frameset//EN” “http://www.w3.org/TR/html4/frameset.dtd” &gt;
<html><head><title>Mailbox Enabled Features</title><meta http-equiv=”refresh” content=”120″ />
<style type="text/css">
<!–
body {
font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
}
 
#report { width: 835px; }
 
table{
border-collapse: collapse;
border: none;
font: 10pt Verdana, Geneva, Arial, Helvetica, sans-serif;
color: black;
margin-bottom: 10px;
}
 
table td{
font-size: 12px;
padding-left: 0px;
padding-right: 20px;
text-align: left;
}
 
table th {
font-size: 12px;
font-weight: bold;
padding-left: 0px;
padding-right: 20px;
text-align: left;
}
 
h2{ clear: both; font-size: 130%;color:#354B5E; }
 
h3{
clear: both;
font-size: 75%;
margin-left: 20px;
margin-top: 30px;
color:#475F77;
}
 
p{ margin-left: 20px; font-size: 12px; }
 
table.list{ float: left; }
 
table.list td:nth-child(1){
font-weight: bold;
border-right: 1px grey solid;
text-align: right;
}
 
table.list td:nth-child(2){ padding-left: 7px; }
table tr:nth-child(even) td:nth-child(even){ background: #BBBBBB; }
table tr:nth-child(odd) td:nth-child(odd){ background: #F2F2F2; }
table tr:nth-child(even) td:nth-child(odd){ background: #DDDDDD; }
table tr:nth-child(odd) td:nth-child(even){ background: #E5E5E5; }
div.column { width: 320px; float: left; }
div.first{ padding-right: 20px; border-right: 1px grey solid; }
div.second{ margin-left: 30px; }
table{ margin-left: 20px; }
</style>
</head> 
"@
$date = Get-Date
   
#Get-CASMailbox *@digital.homeoffice.gov.uk -ResultSize Unlimited |Select Name,ActiveSyncEnabled,OWAEnabled,PopEnabled,ImapEnabled,MapiEnabled |ConvertTo-Html -as table -Head $head -PreContent “<P>The current list of users and which mailbox features are enabled.</P>” -PostContent “<h3><br>Created on $date</h3>” |Out-File c:\o365\mail_enabled.html
#Invoke-Item C:\O365\mail_enabled.html

#Save to our reports section
