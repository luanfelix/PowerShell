### CENTRALIT | EBSERH ####
### Contato: luan.coelho@centralit.com.br


$StatusService = Get-Service -Name AdobeARMservice

    if ($StatusService.Status -ne "Running"){

    Start-Service AdobeARMservice
    Write-Host "O serviço foi ativo"
    }

    if ($StatusService.Status -eq "Running"){ 
    Write-Host "O serviço ja esta ativo"
    }