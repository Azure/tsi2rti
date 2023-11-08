# Define Variables
$AppId = ""
$Secret = ""
$TenantId = ""
$Environment_FQDN = "a563527c-3ac8-4cc8-8cfd-ac2633c0eb0e.env.timeseries.azure.com" #without https
$ADXuri = "https://ingest-kvc-0c8bpxbke5e6g64gn1.northeurope.kusto.windows.net;Fed=True"
$db = "MyDatabase"
$t = "tsi_historical"
$pkgroot = "C:\Microsoft.Azure.Kusto.Tools\tools\net6.0"
$startDate = "2023-10-27T23:59:59"
$endDate = "2023-10-27T23:54:59"

# Do not change anything after this line
$Resource = "https://api.timeseries.azure.com/"
$TokenUri = "https://login.microsoftonline.com/$TenantID/oauth2/token/"
$Body     = "client_id=$AppId&client_secret=$Secret&resource=$Resource&grant_type=client_credentials"
$URI = "https://$Environment_FQDN/events?api-version=2016-12-12"

$null = [System.Reflection.Assembly]::LoadFrom("$pkgroot\Kusto.Data.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$pkgroot\Kusto.Ingest.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$pkgroot\Kusto.Cloud.Platform.dll")

class T {
    [string] $json
    T(
        [string] $json
    ){
        $this.json = $json
    }
}


# Get an access token for TSI
$TokenResult = Invoke-RestMethod -Uri $TokenUri -Body $Body -Method "POST"
$tokenTsi = $TokenResult.access_token

# Define headers for the TSI request
$headersTsi = @{Authorization="Bearer $tokenTsi"}

# Define start date and end date
$startDateTime = [DateTime]::ParseExact($startDate, "yyyy-MM-ddTHH:mm:ss", $null)
$endDateTime = [DateTime]::ParseExact($endDate, "yyyy-MM-ddTHH:mm:ss", $null)

$s = [Kusto.Data.KustoConnectionStringBuilder]::new($ADXuri, $db)
$c = [Kusto.Ingest.KustoIngestFactory]::CreateQueuedIngestClient($s)


# Loop for each 30 seconds to get data
while ($startDateTime -gt $endDateTime) {
    # Define search span for the current day
    $toDate = $startDateTime.ToString("yyyy-MM-ddTHH:mm:ss.000Z")
    $fromDate = $startDateTime.AddSeconds(-30).ToString("yyyy-MM-ddTHH:mm:ss.000Z") 

    # Set body for TSI
    $eventsBody = @"
{
    "searchSpan": {
        "from": {
            "dateTime": "$fromDate"
        },
        "to": {
            "dateTime": "$toDate"
        }
    },
    "take": 10000,
    "sort": [
    {
      "input": {
        "builtInProperty": "$ts"
      },
      "order": "Dsc"
    }
  ]
}
"@

  try{  
    # Get the data from TSI
    $eventsResponse = Invoke-WebRequest -Method POST -Headers $headersTsi -Uri $URI -Body $eventsBody
    $eventsObject = ConvertFrom-Json -InputObject $eventsResponse.Content
    $events = $eventsObject.events
    
    [T[]]$x = $events | ConvertTo-Json -Depth 10
   
    $p = [Kusto.Ingest.KustoQueuedIngestionProperties]::new($db, $t)
    $p.AdditionalProperties["creationTime"] = $startDateTime

    $dr = New-Object Kusto.Cloud.Platform.Data.EnumerableDataReader[T] ($x, 'json')
    $r = $c.IngestFromDataReaderAsync($dr,$p)
    $r
    $r.Result.GetIngestionStatusCollection()
}
  catch {
      Write-Error "Request failed: $_"
  }

# Decrement by 30 sec
$startDateTime = $startDateTime.AddSeconds(-30)   
}
