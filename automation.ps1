$domains = "rexnord.com","zurn.ad"
$fromdate="14-08-2020"
$todate="15-08-2020"
$outputDir ="D:\PowerShellScripts\SecurityAutomation\output\"

######################################################################################################################
#param([string] $domains,
      #[string[]] $domains,     
#      [string] $outputDir
#    )


#$fromdate = (Get-Date).AddDays(-1).ToString('dd-MM-yyyy')
#$todate = get-date -format dd-MM-yyyy

write-host "Fromdate: " $fromdate, "ToDate: "$todate

$outputfile = $outputDir+"csv\outputcsv_"+$todate+".csv"

######################################################################################################################
#convert String object to DateTime object
$fromdate_parsed = [datetime]::Parse($fromdate)
$todate_parsed = [datetime]::Parse($todate)

#loop for range of dates
for ( $date = $fromdate_parsed; $date -le $todate_parsed; $date=$date.AddDays(1) )  
{

#fetch only date from datetime object
$formatted_date = $date.ToString('dd-MM-yyyy')
write-host $formatted_date

#loop through the domains 
foreach($domain in $domains)
{
write-host $domain
Get-ADUser -Filter * -Server $domain -Properties sAMAccountName,DisplayName, EmailAddress,AccountExpirationDate | where {$_.AccountExpirationDate -ne $null -and $_.AccountExpirationDate.ToString() -like "$formatted_date*"}| Select sAMAccountName,DisplayName, EmailAddress,AccountExpirationDate | export-csv $outputfile -Append
}

}

######################################################################################################################
#convert csv to xml output

$Clixmloutputfile = $outputDir+"outputXML_"+$todate+".xml"
write-host "Outputfile: "  $Clixmloutputfile
Import-Csv -Path $outputfile | Export-Clixml -Path $Clixmloutputfile


######################################################################################################################