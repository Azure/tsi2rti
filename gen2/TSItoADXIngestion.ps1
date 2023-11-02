Install-Package Microsoft.Azure.Kusto.Tools -MinimumVersion 6.0.3 -Verbose


#Verify the package is installed at the below location
$workingdir = 'C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.Azure.Kusto.Tools.6.0.3\tools\net5.0'

cd $workingdir

# Connect to Azure
Connect-AzAccount

#Set-AzSubscription 
$subscriptioname = ''

Set-AzContext -SubscriptionName $subscriptioname 

# Get Storage Account key

$resourcegroupname = ''
$storageaccountname = ''

$storageaccountkey = ((Get-AzStorageAccountKey -ResourceGroupName $resourcegroupname -Name $storageaccountname) | Where-Object {$_.KeyName -eq "key1"}).Value

# Get list of storage containers
$storageContext = New-AzStorageContext -StorageAccountName $storageaccountname -StorageAccountKey $storageaccountkey

$containerlist = Get-AzStorageContainer -Context $storageContext

# ADX information
$clusteringesturl = ''
$adxdatabasename = ''
$adxtablename = ''
$fileformat = 'parquet'
$ingestionmapping = ''


#Loop through the containers to ingest data
foreach($name in $containerlist.Name)
{
    $source = "https://${storageaccountname}.blob.core.windows.net/${name}/;${storageaccountkey}"
    $tag = New-Guid

    .\LightIngest.exe "${clusteringesturl};Fed=True" -database:$adxdatabasename `
    -table:$adxtablename `
    -source:$source `
    -format:$fileformat -pattern:"*" `
    -ingestionMappingRef:$ingestionmapping -tag:$tag -creationTimePattern:"'/'yyyyMMddHHmmssfff'_'"
}
