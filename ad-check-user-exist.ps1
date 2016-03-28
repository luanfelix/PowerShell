<#
  *************************************************************************************
  O Codigo abaixo tem a finalidade de verificar se as contas que estão no arquivo CSV
  ja existem na arvore do AD.
  *************************************************************************************
#>

Import-Module ActiveDirectory

$result = Import-Csv 'C:\arquivo.csv' | ForEach-Object {

$SamAccountName = $_. 'SamAccountName'

#realiza a busca da conta
$check = Get-ADuser -LDAPFilter "(sAMAccountName=$SamAccountName)"

#verifica se a conta existe
if ($check -eq $Null){
 $SamAccountName
}

}

#exibe as contas que não existem na tela
$result | Out-GridView -Title 'CONTAS QUE NÃO EXISTEM' 

