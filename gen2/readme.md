# TSI Gen2 to ADX/Fabric KQLDB
Using the PowerShell script is the prefered method; it is fast without needing additional resources. It will migrate only the contents of PT=Time folder. This is the required folder which has all the historical data, except for latest ~5 minutes. Hot (new) data should of been migrated prior using a new consumer group from streaming source, ie. hubs, to ADX/KQLDB. A low-code/no-code approach is also available using ADF/Fabric Pipelines. 

First use the Get Data wizard or [OneClick UI](https://dataexplorer.azure.com/oneclick) to create the hist table and mapping using one of the oldest files in PT=Time folder. The preview screen should display metric names (tags) and values. 

Second, if your historical data requires additional transformations/flattening, create any necessary [partition policies](https://learn.microsoft.com/azure/data-explorer/kusto/management/partitioning-policy) for performance optimizations or KQL functions to normalize the records from the source hist table and enable the Update Policy on the destination/target table. Then proceed with running the tool (PowerShell script or ADF/Fabric Pipeline, whichever you prefer) for rest of migration. This way any required transformations will be applied in-realtime as historical data is migrated.

- If you want to skip the storage part of the script you can delete lines 18-23 and replace the `$source` value with a Sas URL. You create this Sas URL from the container of your TSI env, navigate to the PT=Time folder, click generate Sas, grant it List & Read permissions, extend the expiration date out a few days and copy the Sas URL to the script.

- If you identify during preview of the Get Data wizar or OneClick UI that your TSI envs have different schemas then follow one of these options:
  - **Preferred:** Create a table for each env with their own corresponding mappings. Alternatively, if they're the same schema you can migrate to the same table.
  - Load to a single table supporting different TSI env schemas then use a table with a single column of datatype `dynamic`. ie. `.create table tsihistoricalraw (message:dynamic)`. Since the incomming historical data contains different schemas, you still need to create sperate KQL functions and tables with update policies to flatten them into separate columns. This lets you migrate the historical data quicker but takes more time compared to having created separate tables as mentioned above.


## PowerSheell Pre-reqs 🔍
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

## Tools 🛠️
### Light Ingest 
- CLI Command tool to ingest data from Azure Storage into ADX 
- Commonly used to backfill a table or migrate historical data.
- Example for csv files on local
```
LightIngest "Data Source=https://ingest-demo.westus.kusto.windows.net;AAD Federated Security=True" -db:demo -table:Trips -source:"" -pattern:"*.csv.gz" -format:csv -limit:2 -ignoreFirst:true -cr:10.0 -dontWait:true
```
- Example of backfill using `creationTimePattern` param for parquet files on azure blob. See More: [How to ingest data using CreationTime](https://docs.microsoft.com/azure/data-explorer/lightingest#how-to-ingest-data-using-creationtime)
```
LightIngest "Data Source=https://ingest-demo.eastus.kusto.windows.net;AAD Federated Security=True" -db:demo -table:Trips -source:"https://demo.blob.core.windows.net/adx" -creationTimePattern:"'historicalvalues'yyyyMMdd'.parquet'" -pattern:"*.parquet" -format:parquet -limit:2 -cr:10.0 -dontWait:true
```
- See help using `lightingest.exe /help`

### Example
![image](https://github.com/Azure/tsi2adx/assets/4984616/8af0f935-605e-42af-9713-049f92b0e6d1)


## Post Data Migration 🏁
- Verify all the data was migrated.
- Migrate dashboard from TSI to ADX/KQLDB using PBI, ADX Dashboards/Real Time Analytics dashboards, Grafana, [Kusto trender](https://aka.ms/kusto.trender) or Seeq using [ADX/KQLDB connector](https://support.seeq.com/kb/latest/cloud/azure-data-explorer-adx).
- Check metrics in Log Analytics or Insights blade for Successful Ingestion and verify it matches the number of blobs in PT=Time folders. For example, using the Log Analytics Workspace for the cluster diags, this will provide the number of blobs ingested:
```kql
SucceededIngestion 
| where Table == 'tsihistorical' 
| summarize dcount(IngestionSourcePath) 
```
- Monitor for ingestion failures using [Metrics for queued ingestion](https://learn.microsoft.com/azure/data-explorer/monitor-queued-ingestion) and Insights blade. For example, using KQL:
```kql
.show ingestion failures
```
- Run some basic KQL queries to explore the data in ADX
```kql
tsihistorical
| take 10

tsihistorical
| summarize min(timestamp), max(timestamp)

tsihistorical
| summarize max(ingestion_time())
```
- Verify historical has been indexed properly (backfilled) where extents MaxCreatedDate is in the past aligned to contents of PT=Time folder, not as of today.
```kql
tsihistorical
|summarize max(timestamp), min(timestamp)
 
.show extents
|where TableName =='tsihistorical'
|summarize max(MaxCreatedOn)
 
.show extents
|where TableName =='tsihistorical'
|summarize count() by bin(MaxCreatedOn,7d)
|render timechart
```


## TSI Folders Details 📖
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
