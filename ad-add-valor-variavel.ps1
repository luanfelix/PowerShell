<#
		***********************************************************
			O script abaixo adiciona um valor a existente no
			arquivo csv a variável 'siape'
		***********************************************************

#>
 
Import-Module ActiveDirectory

Import-Csv 'C:\arquivo.csv'  | ForEach-Object {

$SamAccountName = $_. 'SamAccountName'
$siape = $_. 'siape'

Set-ADUser -Identity $SamAccountName -Add @{siape = $siape}
}
