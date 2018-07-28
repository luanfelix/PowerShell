#CPF para validacao
$CPF = "13555097342"
$DV  = $CPF.Substring(9)

#Consulta do primeiro digito verificador
$CheckCPF = $CPF.Substring(0,$CPF.Length-2)
$sequencia = 10..2
$array = [int[]](($CPF -split '') -ne '')
 
$soma = 0
$i = 0
$sequencia | foreach{
write-host $_ -ForegroundColor Green
write-host $array[$i] -ForegroundColor Red
$soma += $_ * $array[$i]
$i++
$soma
}
 
$Resto = $soma % 11

if($Resto -ilt 2){
$pDV = 0
}else{
$pDV = 11 - $Resto
}

$pDV
 
#Consulta do segundo digito verificador
$CheckCPF = $CPF.Substring(0,$CPF.Length-1)
$sequencia = 11..2
$array = [int[]](($CPF -split '') -ne '')
 
$soma = 0
$i    = 0

$sequencia | foreach{
write-host $_ -ForegroundColor Green
write-host $array[$i] -ForegroundColor Red
$calc = $_ * $array[$i]
Write-Host $calc -ForegroundColor Yellow 
$soma += $calc
$i++
$soma
}
 
$Resto = $soma % 11
 
if($Resto -ilt 2){
$sDV = 0
}else{
$sDV = 11 - $Resto
}
$sDV

#Validacao do CPF
$ResultDV = "$pDV"+"$sDV"
if($ResultDV -eq $DV){
Write-Host "CPF Valido!" -ForegroundColor Green
}else{
Write-Host "CPF Invalido!" -ForegroundColor Red
}