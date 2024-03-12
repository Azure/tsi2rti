# TSI Gen2 to ADX/Fabric KQLDB
Using the PowerShell script is the prefered method; it is fast without needing additional resources. It will migrate only the contents of PT=Time folder. This is the required folder which has all the historical data, except for latest ~5 minutes. Hot (new) data should of been migrated prior using a new consumer group from streaming source, ie. hubs, to ADX/KQLDB. A low-code/no-code approach is also available using ADF/Fabric Pipelines. 

First use the Get Data wizard or [OneClick UI](https://dataexplorer.azure.com/oneclick) to create the hist table and mapping using one of the oldest files in PT=Time folder. The preview screen should display metric names (tags) and values.
Second, if your historical data requires additional transformations/flattening, create any necessary KQL functions to normalize the records from the source hist table and enable the Update Policy on the destination/target table. Then proceed with running the tool (PowerShell script or ADF/Fabric Pipeline, whichever you prefer) for rest of migration. This way any required transformations will be applied in-realtime as historical data is migrated.

## PowerSheell Pre-reqs:
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

## TSI Folders Details
This section briefly explains he nature of files in PT=Live, PT=Time and PT=TsId folders.

When data are initially ingested into Cold Store, they land in PT=Live folder. Periodically (~ every several mins) TSI merges data from PT=Live files into a single file in PT=Time and after some time deletes original files in PT=Live.

There is another periodic process which takes files in PT=Time and repartition them into the files in PT=TsId. This repartitioning is done so events with the same Time Series ID value land in the same file. Is it needed to optimize query for a given Time Series ID value so minimal number of files is scanned in Cold Store.

Files in PT=TsId can be further repartitioned into other files in PT=TsId. Original files in PT=TsId are then deleted after some time.

Files in PT=Time are never deleted.

This means the recommendation is to **never consume files in PT=TsId** and **always consume files in PT=Time**. Whether to additionally consume files in PT=Live depends on customer's needs:
- As you see files in PT=Live and PT=Time contain duplicate data. PT=Live files contain the most recent data (typically several 10s of seconds of latency). **Data in PT=Time land with some latency (can be around 5 mins)**.
- If it is critical for the customer to get all the recent data and they are OK with having duplicate data, then they should consume PT=Live files.
- If it is critical for them to avoid duplicate data and they are OK not to get the recent data (because e.g., they have other way to migrate recent data to ADX/KQLDb), then **only** PT=Time files should be consumed.

FYI before TSI was deprecated when customer wanted to query files in Cold Store using some 3rd party tools like Spark, then we always recommended querying **PT=Time folder only** to avoid duplicate data and we warned customer that they might not see data for the latest ~5 mins.

