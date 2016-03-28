<#

    ***************************************************************************
    O script abaixo busca um serviço pelo nome informado, verifica o status do
    serviço e realiza uma ação de acordo com o comando de decisão 'if'.
    ***************************************************************************

#>
 
$service = get-service | where-object { $_.Name -like "SepMasterService" }

    if ($service.DisplayName -eq "Symantec Endpoint Protection" -and  $service.Status -eq "Running"){

        Write-Host Serviço Instalado
        
        # pode ser utilizado a ação de iniciar o serviço com a linha abaixo    
        #start-service Symantec Endpoint Protection

        }
        else{
            Write-Host instalar serviço!

        }
