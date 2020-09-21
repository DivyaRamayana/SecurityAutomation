$date="14-08-2020"
#Get-ADUser -Filter * -Properties AccountExpirationDate | where {$_.AccountExpirationDate -ne $null -and $_.AccountExpirationDate.ToString() -like "$date*"}| Select sAMAccountName, AccountExpirationDate | export-csv "D:\ActiveDirectory\GetUserExpirydate.csv"
Get-ADUser -Filter * -Server "rexnord.com","zurn.com" -Properties sAMAccountName,DisplayName, EmailAddress,AccountExpirationDate | where {$_.AccountExpirationDate -ne $null -and $_.AccountExpirationDate.ToString() -like "$date*"}| Select sAMAccountName,DisplayName, EmailAddress,AccountExpirationDate
