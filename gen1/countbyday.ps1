# Define Variables
$AppId = ""
$Secret = ""
$TenantId = ""
$Environment_FQDN = "a563527c-3ac8-4cc8-8cfd-ac2633c0eb0e.env.timeseries.azure.com" #without https
$startDate = Get-Date "2023-10-01"
$endDate = Get-Date "2023-10-30"

$Resource = "https://api.timeseries.azure.com/"
$TokenUri = "https://login.microsoftonline.com/$TenantID/oauth2/token/"
$Body = "client_id=$AppId&client_secret=$Secret&resource=$Resource&grant_type=client_credentials"

$TokenResult = Invoke-RestMethod -Uri $TokenUri -Body $Body -Method "POST"
$token = $TokenResult.access_token

$headers = @{
    Authorization = "Bearer $token"
    'Content-Type' = 'application/json'
}
$URI = "https://$Environment_FQDN/aggregates?api-version=2016-12-12"

# Loop through each day in the date range
for ($date = $startDate; $date -le $endDate; $date = $date.AddDays(1)) {
    # Format the start and end times for the current day
    $fromDateTime = $date.ToString("yyyy-MM-ddT00:00:00.000Z")
    $toDateTime = $date.AddDays(1).ToString("yyyy-MM-ddT00:00:00.000Z")

    # Create the request body for the current day
    $aggregateBody = @"
{
    "searchSpan": {
        "from": {
            "dateTime": "$fromDateTime"
        },
        "to": {
            "dateTime": "$toDateTime"
        }
    },
    "aggregates": [{
        "measures": [{
            "count": {}
        }]
    }]
}
"@

    try {
        $aggregateResponse = Invoke-RestMethod -Method POST -Headers $headers -Uri $URI -Body $aggregateBody
        $count = $aggregateResponse.aggregates.measures
        Write-Output "Count for $($date.ToString("yyyy-MM-dd")): $count"
    }
    catch {
        Write-Error "Error: $_"
        
    }
}

