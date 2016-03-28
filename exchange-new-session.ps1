# Abrir sessão remota no servidor Exchange via PowerShell

 $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://sede-vp-exmbx1.ebserhnet.ebserh.gov.br/PowerShell/ -Authentication Kerberos
 Import-PSSession $Session