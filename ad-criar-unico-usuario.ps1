<#

  **************************************************************************
  O codigo abaixo cria um usuário no AD a partir dos valores carregados 
  pelo usuário na tela do powershell.
  **************************************************************************
#>

Import-Module ActiveDirectory

$location = "CN=Users,DC=ebserhnet,DC=ebserh,DC=gov,DC=br"
$Name = Read-Host "Nome completo"
$GivenName = Read-Host "Primeiro nome"
$Surname = Read-Host "Ultimo nome"
$EmployeeID = Read-Host "CPF"
$siape = Read-Host "SIAPE"
$Office = Read-Host "Sigla do HU"
$Title = Read-Host "Cargo"
$Department = Read-Host "Departamento"
$SamAccountName = Read-Host "Login"
$Country = Read-Host "País" 
$Company = 'EBSERH'
#$password = Read-Host 'Password'


$Domain = '@ebserh.gov.br'
$userPrincipalName = $SamAccountName + $Domain
 

If ($Country -eq "Brasil") {$Country = "BR"} 

$GetAdminact = Get-Credential
New-ADUser -Credential $GetAdminact `
 -Name $Name `
 -Path  $location `
 -SamAccountName  $SamAccountName `
 -DisplayName $Name `
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

 # Abre uma nova sessão no Exchange para ativar a conta de e-mail do usuário criado acima
 
 $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://sede-vp-exmbx1.ebserhnet.ebserh.gov.br/PowerShell/ -Authentication Kerberos
 Import-PSSession $Session
 Enable-Mailbox -Identity $SamAccountName -Database P2DB10