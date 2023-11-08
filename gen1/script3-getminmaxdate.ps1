# Define Variables
$AppId = ""
$Secret = ""
$TenantId = ""
$Environment_FQDN = "a563527c-3ac8-4cc8-8cfd-ac2633c0eb0e.env.timeseries.azure.com" #without https

$Resource = "https://api.timeseries.azure.com/"
$TokenUri = "https://login.microsoftonline.com/$TenantID/oauth2/token/"
$Body     = "client_id=$AppId&client_secret=$Secret&resource=$Resource&grant_type=client_credentials"

$TokenResult = Invoke-RestMethod -Uri $TokenUri -Body $Body -Method "POST"
$token = $TokenResult.access_token

$headers = @{Authorization="Bearer $token"}
$URI = "https://$Environment_FQDN/availability?api-version=2016-12-12"

$Response = Invoke-WebRequest -Method GET -Headers $headers -Uri $URI

$Response.Content
