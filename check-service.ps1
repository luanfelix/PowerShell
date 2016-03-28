
﻿<# 
﻿Este codigo tem a finalidade de buscar um serviço pelo nome no windows 
﻿e verificar se esta sendo executado.
﻿#>
﻿
    $StatusService = Get-Service -Name name service

    #check se o serviço esta ativo
    if ($StatusService.Status -ne "Running"){

    #se não estiver o serviço é iniciado
    Start-Service name service
    Write-Host "O serviço foi ativo"
    }

    #se estiver apenas escreve na tela serviço ativo
    if ($StatusService.Status -eq "Running"){ 
    Write-Host "O serviço ja esta ativo"
    }
