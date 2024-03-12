#params
$pkgroot = "C:\Microsoft.Azure.Kusto.Tools\tools\net6.0"
$workingdir = $pkgroot  #change location of lightingest.exe if different from pkgroot.
$clusteringesturl = '' #adx/kqldb cluster ingestion uri
$adxdatabasename = ''
$adxtablename = ''
$ingestionmapping = ''  # not required if loading to a table with a single dyanmic column.
$subscriptioname = ''  # Subscription of storage account.
$resourcegroupname = ''  # RG of storage account.
$storageaccountname = ''  # Name of storage account.

#dependencies
$null = [System.Reflection.Assembly]::LoadFrom("$pkgroot\Kusto.Data.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$pkgroot\Kusto.Ingest.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$pkgroot\Kusto.Cloud.Platform.dll")
cd $workingdir

#storage
Connect-AzAccount
Set-AzContext -SubscriptionName $subscriptioname 
$storageaccountkey = ((Get-AzStorageAccountKey -ResourceGroupName $resourcegroupname -Name $storageaccountname) | Where-Object {$_.KeyName -eq "key1"}).Value
$storageContext = New-AzStorageContext -StorageAccountName $storageaccountname -StorageAccountKey $storageaccountkey
$containerlist = Get-AzStorageContainer -Context $storageContext


#ingest
foreach($name in $containerlist.Name)
{
    $source = "https://${storageaccountname}.blob.core.windows.net/${name}/;${storageaccountkey}"
    $tag = New-Guid

    .\LightIngest.exe "${clusteringesturl};Fed=True" -database:$adxdatabasename `
    -table:$adxtablename `
    -source:$source `
    -format:"parquet" `
    -pattern:"*" `
    -prefix:"V=1/PT=Time" `
    -ingestionMappingRef:$ingestionmapping -tag:$tag -creationTimePattern:"'/'yyyyMMddHHmmssfff'_'"
}
