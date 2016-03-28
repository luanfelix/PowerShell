
<#

  ************************************************************
   Este script tem a finalidade de criar usuários em lote a
   partir de um arquivo .csv.
  ************************************************************

#>


Import-Module ActiveDirectory
$ADServer = 'sede-vp-ad1'
$location = "OU=Usuarios,OU=MEAC,OU=UFC,OU=EBSERH,DC=ebserhnet,DC=ebserh,DC=gov,DC=br"


Import-Csv 'C:\arquivo.csv'  | ForEach-Object { 

$Name = $_. 'Name'
$GivenName = $_.'First Name'
$Surname = $_.'Last Name'
$DisplayName = $_.'Display Name'
$EmployeeID = $_. 'CPF'
$Country = $_.'Country/Region' 
$Title = $_. 'Title'
$SamAccountName = $_. 'Conta'
$Company = $_. 'Company'
$Department = $_.'Department'
$Office = $_.'Office'
$password = $_.'Password'
$siape = $_. 'SIAPE'
$Domain = '@ebserh.gov.br'
$userPrincipalName = $SamAccountName + $Domain 

If ($Country -eq "Brasil") {$Country = "BR"} 


New-ADUser `
 -Name $Name `
 -Path  $location `
 -SamAccountName  $sam `
 -DisplayName $DisplayName `
 -AccountPassword (ConvertTo-SecureString "Ebserh@2016" -AsPlainText -Force) `
 -ChangePasswordAtLogon $true  `
 -Enabled $true `
 -GivenName $GivenName `
 -Surname $Surname `
 -EmployeeID $EmployeeID `
 -Title $Title `
 -Company $Company `
 -Department $Department `
 -Office $Office `
 -UserPrincipalName $userPrincipalName `
 -OtherAttributes @{'siape'= $siape}

    }