<#
	*********************************************************
		Deleta contas em lote a partir de um arquivo .CSV
	*********************************************************
#>

Import-Module ActiveDirectory

	Import-Csv 'C:\arquivo.csv'  | ForEach-Object {

		$SamAccountName = $_. 'SamAccountName'

		Remove-ADUser -Identity $SamAccountName -Confirm:$false
}