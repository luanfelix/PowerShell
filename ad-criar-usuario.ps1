<#

  **************************************************************************
  O codigo abaixo cria um usuário no AD a partir dos valores inseridos.
  **************************************************************************
#>


Import-Module ActiveDirectory
New-ADUser `
 -Name "Felipe Filgueira Marinho" `
 -Path  "CN=Users,DC=ebserhnet,DC=ebserh,DC=gov,DC=br" `
 -SamAccountName  "felipe.marinho" `
 -DisplayName "Felipe Filgueira Marinho" `
 -AccountPassword (ConvertTo-SecureString "Ebserh@2016" -AsPlainText -Force) `
 -ChangePasswordAtLogon $true  `
 -Enabled $true `
 -GivenName "Felipe" `
 -Surname "Filgueira Marinho" `
 -EmployeeID "01461375150" `
 -Title "Analista de Sistemas JAVA"`
 -Company "EBSERH"`
 -Department "DGPTI/CDSI"`
 -Office "SEDE"`
 -userPrincipalName "felipe.marinho@ebserh.gov.br"
