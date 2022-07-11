import-module IISAdministration 
import-module WebAdministration
$apppools = Get-IISAppPool
foreach($pool in $apppools.Name) {
	Stop-WebAppPool $pool
}

foreach($pool in $apppools.Name) {
	Start-WebAppPool $pool
}


$subsc = Get-AzSubscription -SubscriptionName Development
Set-AzContext -Subscription $subsc.Id
$rg = Get-AzResourceGroup | where-object {$_.ResourceGroupName -like "load*"}
$sqlServer = get-azSqlserver -ResourceGroupName $rg.ResourceGroupName
echo $sqlServer.ServerName
$dbName = get-azsqldatabase -ServerName $sqlServer.ServerName -ResourceGroupName $rg.ResourceGroupName | where-object {$_.DatabaseName -eq "loadtestdev2Content_Performance"}
