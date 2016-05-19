################################################################################################################################################################  
#  Hacked by D Edwards Based on script from https://gallery.technet.microsoft.com/scriptcenter/List-all-Users-Distribution-7f2013b2
#  
#  Removed enter user credentials as we assume reporting is run in a valid user session
#  
#  
# Original Author:                 Alan Byrne  
# Version:                 2.0  
# Last Modified Date:     16/08/2014  
# Last Modified By:     Alan Byrne alan@cogmotive.com  
################################################################################################################################################################  
  
  
#Constant Variables  
$OutputFile = "c:\o365\DistributionGroupMembers.csv"   #The CSV Output file that is created, change for your purposes  
$arrDLMembers = @{}  
        
  
#Prepare Output file with headers  
Out-File -FilePath $OutputFile -InputObject "Distribution Group DisplayName,Distribution Group Email,Member DisplayName, Member Email, Member Type" -Encoding UTF8  
  
#Get all Distribution Groups from Office 365  
$objDistributionGroups = Get-DistributionGroup -ResultSize Unlimited  
  
#Iterate through all groups, one at a time      
Foreach ($objDistributionGroup in $objDistributionGroups)  
{      
     
    write-host "Processing $($objDistributionGroup.DisplayName)..."  
  
    #Get members of this group  
    $objDGMembers = Get-DistributionGroupMember -Identity $($objDistributionGroup.PrimarySmtpAddress)  
      
    write-host "Found $($objDGMembers.Count) members..."  
      
    #Iterate through each member  
    Foreach ($objMember in $objDGMembers)  
    {  
        Out-File -FilePath $OutputFile -InputObject "$($objDistributionGroup.DisplayName),$($objDistributionGroup.PrimarySMTPAddress),$($objMember.DisplayName),$($objMember.PrimarySMTPAddress),$($objMember.RecipientType)" -Encoding UTF8 -append  
        write-host "`t$($objDistributionGroup.DisplayName),$($objDistributionGroup.PrimarySMTPAddress),$($objMember.DisplayName),$($objMember.PrimarySMTPAddress),$($objMember.RecipientType)" 
    }  
}  
 
