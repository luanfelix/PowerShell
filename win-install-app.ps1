
<#

    *********************************************************************************
    O script abaixo verifica os programas instalados na máquina e caso a versão não
    esteja de acordo ele executa a instalação do arquivo .exe. Pode ser utilizado
    tambem para realizar a primeira instalação do programa.
    *********************************************************************************

#>



$app = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*

    if ($app.DisplayName -eq "UltraVnc" -and  $app.DisplayVersion -eq "1.0.0.9"){

    Start-Process -FilePath 'C:\Users\luan.coelho\Desktop\UltraVNC_1_2_09_X64_Setup.exe' -ArgumentList '/silent', '/install' -Wait

    }
else{
    Write-Host Programa Atualizado!

    }
