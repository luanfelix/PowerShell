# Abrir sessão remota no servidor Exchange via PowerShell

 $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://server.com.br/PowerShell/ -Authentication Kerberos
 Import-PSSession $Session
