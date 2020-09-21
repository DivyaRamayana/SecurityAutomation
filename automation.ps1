$domains = "rexnord.com","zurn.ad"
$date="14-08-2020"
#Get-ADUser -Filter * -Properties AccountExpirationDate | where {$_.AccountExpirationDate -ne $null -and $_.AccountExpirationDate.ToString() -like "$date*"}| Select sAMAccountName, AccountExpirationDate | export-csv "D:\ActiveDirectory\GetUserExpirydate.csv"
foreach($domain in $domains)
{
Get-ADUser -Filter * -Server $domain -Properties sAMAccountName,DisplayName, EmailAddress,AccountExpirationDate | where {$_.AccountExpirationDate -ne $null -and $_.AccountExpirationDate.ToString() -like "$date*"}| Select sAMAccountName,DisplayName, EmailAddress,AccountExpirationDate
}