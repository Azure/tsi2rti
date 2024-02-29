##  PowerSheell Pre-reqs:

```
Invoke-WebRequest -Uri https://nuget.org/api/v2/package/Microsoft.Azure.Kusto.Tools -OutFile Microsoft.Azure.Kusto.Tools.zip
Expand-Archive .\Microsoft.Azure.Kusto.Tools.zip -Destination "C:\Microsoft.Azure.Kusto.Tools\" -Force
Remove-Item .\Microsoft.Azure.Kusto.Tools.zip -force
```
Install PowerShell 7: 
```
winget install --id Microsoft.Powershell --source winget
```
Install AzCLI: 
```
install-module az
```

- ref: https://learn.microsoft.com/azure/data-explorer/lightingest
- OneClick wizard to create table & lightingest command: https://dataexplorer.azure.com/oneclick


# TSI Gen2 to ADX/Fabric KQLDB

[wip] - work in progress
- screenshots of lightingest from pptx
- link to download cli tool
- screenshots of ADF/Fabric Pipelines (no-code/low-code method)
- context when to do one vs other
- considerations for Update Policies, transformations, building out the ingestion, then proceeding with running the tool for rest of migration.
