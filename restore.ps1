#Justin Jans ID#009457058

Function ActiveDirectory
{
    #Defined Function that runs through AD requirements

    #Adds OU
    Write-Host -ForegroundColor Red "Running AD Tasks"
    $AdRoot = (Get-ADDomain).DistinguishedName
    $DnsRoot = (Get-ADDomain).DNSRoot
    $OUCanonicalName = "Finance"
    $OUDisplayName = "Finance"
    $ADPath = "OU=$($OUCanonicalName),$($ADRoot)"

    if (-Not([ADSI]::Exists("LDAP://$($ADPATH)"))) {
        New-ADOrganizationalUnit -Path $AdRoot -Name $OUCanonicalName -DisplayName $OUDisplayName -ProtectedFromAccidentalDeletion $false
        Write-Host -ForegroundColor Red "[AD]: $($OUCanonicalName) OU Created"
    }
    else 
    {
    Write-Host -ForegroundColor Red "$($OUCanonicalName) Already Exists"    
    }

    #Imports and Creates New User
    $NewADUsers = Import-CSV -Path $PSScriptRoot\financePersonnel.csv

    #Status Rerporting
    $numberNewUsers = $NewADUSers.Count
    $count = 1

    #For Loop
    foreach ($ADUser in $NewADUsers)
    {
        $First = $ADUser.First_Name
        $Last = $ADUser.Last_Name
        $Name = $First + " " + $Last
        $SamAcct = $ADUser.samAccount
        $UPN = "$($SamAcct)@$($DnsRoot)"
        $Postal = $ADUser.PostalCode
        $Office = $ADUser.OfficePhone
        $Mobile = $ADUser.MobilePhone

        #Create and show Status
        $status = "[AD]: Adding AD User: $($Name) ($($count) of $($numberNewUsers))"
        Write-Progress -Activity 'C916 Task 2 - Restore' -Status $status -PercentComplete (($count/$numberNewUsers) * 100)
        #Use Variable to create users
        New-ADUser -GivenName $First `
                   -Surname $Last `
                   -Name $Name `
                   -SamAccountName $SamAcct `
                   -UserPrincipalName $UPN `
                   -DisplayName $Name `
                   -PostalCode $Postal `
                   -MobilePhone $Mobile `
                   -OfficePhone $Office `
                   -Path $ADPath `
        
        #Increment counter
        $count++
    }
    Write-Host -ForegroundColor Green "Active Directory Tasks Complete"
}

Function SQLServer
{
    Write-Host -ForegroundColor Red "Beginning SQL Tasks"
    #Import SqlServer Module
    if (Get-Module -Name sqlps) { Remove-Module sqlps }
    Import-Module -Name SqlServer

    #Sql Variables
    $sqlServerInstance = "SRV19-PRIMARY\SQLEXPRESS"
    $databaseName = "ClientDB"


    #Create Object reference to SQL server
    $sqlServerObject = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $sqlServerInstance

    #Create Object reference to Database
    $databaseobject = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -ArgumentList $sqlServerObject, $databaseName

    #Create Database
    $databaseobject.Create()

    Write-Host -ForegroundColor Red "Created Database"

    #Create Table
    Invoke-Sqlcmd -ServerInstance $sqlServerInstance -Database $databaseName -InputFile $PSScriptRoot\Client_A_Contacts.sql
    
    Write-Host -ForegroundColor Red "Created Table"

    #add Records from CSV File

    #Insert Variable
    $tableName = Client_A_Contacts
    $Insert = "Insert into [$($tableName)] (first_name, last_name, city, county, zip, officePhone, mobilePhone)"
    $ClientContacts = Import-CSV $PSScriptRoot\NewClientData.csv

    #ForLoop
    Write-Host -ForegroundColor Red "Inserting Data"
    ForEach ($Client in $ClientContacts) 
    {
        $values = "Values( `
                        '$($Client.first_name)', `
                        '$($Client.last_name)', `
                        '$($Client.city)', `
                        '$($Client.county)', `
                        '$($Client.zip)', `
                        '$($Client.officePhone)', `
                        '$($Client.mobilePhone)')"

        $query = $Insert + $values
        Invoke-Sqlcmd -Database $databaseName -ServerInstance $sqlServerInstance -query $Query   
    }

}




#Main Script
try {
    #ActiveDirectory
    SQLServer
}
Catch [System.OutOfMemoryException]
{
    Write-Host -ForegroundColor Red "System out of memory"
}
Finally
{

}