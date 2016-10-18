###################################################################
#
# Autor: Luan Felix
# e-mail: luanfc1@gmail.com
# Finalidade: monitoramento de saúde dos controladores de domínio.
#
###################################################################




$healthdc			 = "C:\temp\LuanZabbix.csv"
$ParametersDatabases 	 = @()


## Lista os controladores de dominio ##

$getForest = [system.directoryservices.activedirectory.Forest]::GetCurrentForest()
$DCServers = $getForest.domains | ForEach-Object {$_.DomainControllers} | ForEach-Object {$_.Name} | Sort-Object


foreach ($DC in $DCServers)

{

$Identity = $DC
           
$ParametersDatabase = New-Object -TypeName PSObject

$ParametersDatabase | Add-Member -MemberType NoteProperty -Name server -Value $Identity.server      

if ( Test-Connection -ComputerName $DC -Count 1 -ErrorAction SilentlyContinue ) {

$ParametersDatabase | Add-Member -MemberType NoteProperty -Name ping -Value Sucesso
}else{
$ParametersDatabase | Add-Member -MemberType NoteProperty -Name ping -Value Erro
}


##Netlogon Service Status##
		        $serviceStatus = start-job -scriptblock {get-service -ComputerName $($args[0]) -Name "Netlogon" -ErrorAction SilentlyContinue} -ArgumentList $DC
                wait-job $serviceStatus -timeout $timeout
                if($serviceStatus.state -like "Running")
                {
                $ParametersDatabase | Add-Member -MemberType NoteProperty -Name NetlogonService -Value "Netlogon Timeout"
         
                 stop-job $serviceStatus
                }
                else
                {
                $serviceStatus1 = Receive-job $serviceStatus
                 if ($serviceStatus1.status -eq "Running") {
 		   
         	   $svcName = $serviceStatus1.name 
         	   $svcState = $serviceStatus1.status          
         	   $ParametersDatabase | Add-Member -MemberType NoteProperty -Name NetlogonService -Value $svcState.NetlogonService
          
                  }
                 else 
                  { 
       		  
         	  $svcName = $serviceStatus1.name 
         	  $svcState = $serviceStatus1.status          
         	  $ParametersDatabase | Add-Member -MemberType NoteProperty -Name NetlogonService -Value "Falha Serviço" 
                  } 
                }
 ##NTDS Service Status##
		        $serviceStatus = start-job -scriptblock {get-service -ComputerName $($args[0]) -Name "NTDS" -ErrorAction SilentlyContinue} -ArgumentList $DC
                wait-job $serviceStatus -timeout $timeout
                if($serviceStatus.state -like "Running")
                {
                 
                 $ParametersDatabase | Add-Member -MemberType NoteProperty -Name NTDS -Value "NTDS Timeout"
                 stop-job $serviceStatus
                }
                else
                {
                $serviceStatus1 = Receive-job $serviceStatus
                 if ($serviceStatus1.status -eq "Running") {
 		    
         	   $svcName = $serviceStatus1.name 
         	   $svcState = $serviceStatus1.status          
         	   $ParametersDatabase | Add-Member -MemberType NoteProperty -Name NTDS -Value $svcState.NTDS 
                  }
                 else 
                  { 
       		  
         	  $svcName = $serviceStatus1.name 
         	  $svcState = $serviceStatus1.status          
         	  $ParametersDatabase | Add-Member -MemberType NoteProperty -Name NTDS -Value "Falha Serviço" 
                  } 
                }
 
##DNS Service Status##
		        $serviceStatus = start-job -scriptblock {get-service -ComputerName $($args[0]) -Name "DNS" -ErrorAction SilentlyContinue} -ArgumentList $DC
                wait-job $serviceStatus -timeout $timeout
                if($serviceStatus.state -like "Running")
                {

                 $ParametersDatabase | Add-Member -MemberType NoteProperty -Name DNS -Value "DNS Timeout"
                 stop-job $serviceStatus
                }
                else
                {
                $serviceStatus1 = Receive-job $serviceStatus
                 if ($serviceStatus1.status -eq "Running") {
 
         	   $svcName = $serviceStatus1.name 
         	   $svcState = $serviceStatus1.status          
         	   $ParametersDatabase | Add-Member -MemberType NoteProperty -Name DNS -Value $svcState.DNS 
                  }
                 else 
                  { 
  
         	  $svcName = $serviceStatus1.name 
         	  $svcState = $serviceStatus1.status          
         	  $ParametersDatabase | Add-Member -MemberType NoteProperty -Name DNS -Value "Falha DNS"
                  } 
                }


##Netlogons status##
               add-type -AssemblyName microsoft.visualbasic 
               $cmp = "microsoft.visualbasic.strings" -as [type]
               $sysvol = start-job -scriptblock {dcdiag /test:netlogons /s:$($args[0])} -ArgumentList $DC
               wait-job $sysvol -timeout $timeout
               if($sysvol.state -like "Running")
               {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name netlogon -Value "Netlogons Timeout"
               stop-job $sysvol
               }
               else
               {
               $sysvol1 = Receive-job $sysvol
               if($cmp::instr($sysvol1, "passed test NetLogons"))
                  {

                  $ParametersDatabase | Add-Member -MemberType NoteProperty -Name netlogon -Value "Netlogon OK"
                  }
               else
                  {

                  $ParametersDatabase | Add-Member -MemberType NoteProperty -Name netlogon -Value "Falha Netlogon"
                  }
                }

##Replications status##
               add-type -AssemblyName microsoft.visualbasic 
               $cmp = "microsoft.visualbasic.strings" -as [type]
               $sysvol = start-job -scriptblock {dcdiag /test:Replications /s:$($args[0])} -ArgumentList $DC
               wait-job $sysvol -timeout $timeout
               if($sysvol.state -like "Running")
               {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name replication -Value "Replicação Timeout"
               stop-job $sysvol
               }
               else
               {
               $sysvol1 = Receive-job $sysvol
               if($cmp::instr($sysvol1, "passed test Replications"))
                  {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name replication -Value "Replicação OK"
                  }
               else
                  {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name replication -Value "Falha Replicação"
                  }
                }

##Services status##
               add-type -AssemblyName microsoft.visualbasic 
               $cmp = "microsoft.visualbasic.strings" -as [type]
               $sysvol = start-job -scriptblock {dcdiag /test:Services /s:$($args[0])} -ArgumentList $DC
               wait-job $sysvol -timeout $timeout
               if($sysvol.state -like "Running")
               {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name services -Value "Services Timeout"
               stop-job $sysvol
               }
               else
               {
               $sysvol1 = Receive-job $sysvol
               if($cmp::instr($sysvol1, "passed test Services"))
                  {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name services -Value "Services OK"
                  }
               else
                  {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name services -Value "Erro Services"
                  }
                }

##Advertising status##
               add-type -AssemblyName microsoft.visualbasic 
               $cmp = "microsoft.visualbasic.strings" -as [type]
               $sysvol = start-job -scriptblock {dcdiag /test:Advertising /s:$($args[0])} -ArgumentList $DC
               wait-job $sysvol -timeout $timeout
               if($sysvol.state -like "Running")
               {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name advertising -Value "Advertising Timeout"
               stop-job $sysvol
               }
               else
               {
               $sysvol1 = Receive-job $sysvol
               if($cmp::instr($sysvol1, "passed test Advertising"))
                  {
                  
               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name advertising -Value "Advertising OK"
                  }
               else
                  {

               $ParametersDatabase | Add-Member -MemberType NoteProperty -Name advertising -Value "Falha Advertising"
                  }
                }

                $ParametersDatabases += $ParametersDatabase
               
                
} 

$ParametersDatabases | Export-csv $healthdc -NoTypeInformation