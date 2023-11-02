# TSI to ADX Migration Map  

## Customer Introduction 
- Before talking with the customer read through the published migration guidance.  
  - https://docs.microsoft.com/en-us/azure/time-series-insights/migration-to-adx#overview 
  - https://docs.microsoft.com/en-us/azure/time-series-insights/how-to-tsi-gen1-migration 
- Review the PowerPoint deck as an option when talking with your customers (link once deck is done) 

## Meet with Customer (Scoping) 
- The primary goal of meeting is to ease concerns that the customer might have 
- Talking points during meeting  
  - TSI will still be supported for the next 3 years
  - The migration from TSI is to ADX
    - Well documented migration steps
    - Can unlock new scenarios because you will now have full control of your data
    - Visualization Options
      - PowerBI
      - ADX Dashboards
      - Grafana
      - TSI Javascript Controls (embed in your application)
      - https://aka.ms/kusto.trender
      - Seeq (cost money)
      - Etc..
  - TSI is supported for 3 years but no more development. We advise you to migrate as soon as your comfortable
- Migration is side-by-side, you get your ADX environment ready and ensure it meets your needs while still running your TSI environment.
- Outcome of the meeting
  - Pick a TSI Environment that we can walk through the steps with you and migrate the data
  - Other TSI Environments they’ll migrate with you there for support 

## TSI Environment Questions 
How much historical data do you have to migrate in this environment? 
- If they don't know it'll be in the storage account (PT=Time) folder 

Do you have a lot of late arriving data to your ingestion point (Event Hub, IoT Hub)?
- Most customers won’t have a significant amount. You can do a spot check of the blob files in PT=Time.
  - Blob is created with <Blob Creation>_<Min TimeStamp in File>_<Max TimeStamp in File>
  - If you see a lot of files where the <Blob Creation> is way different than your <Min TimeStamp> then you probably have a lot of late arriving data 
- If you have a lot of late arriving data then we won’t use the -CreationTimeStamp option on the lightingest command. Instead will use ADX data partitioning policy before we ingest the data. [Partitioning policy - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/azure/data-explorer/kusto/management/partitioningpolicy)
  
Did you use the TSI Bulk Import tool for this environment? 
- If they did they will have a PT=Impot folder in blob. We'll also need to ingest this folder to get all the data
- Note: Before importing this folder you'll need to set an appropriate ADX data partitioning policy on the timestamp field. Being this was a bulk import the blob isn’t structured in a way that we can use the -CreationTimeStamp field in the LightIngest tool. 

What did your TSI Model look like? 
- We need to understand how heavily they used the TSI Model. This is the most difficult item to recreate in visualization plus it needs to be migrated over. 
- Talk to them about their options for migrating the TSI Model
  - TSI Model -> ADX Table
  - TSI Model -> Azure Digital Twins
- Most customers will start with ADX Table but this is a good opportunity to introduce Azure Digital Twins and talk about its advantages. 

Visualization Options 
- PowerBI ([Connected Devices - Power BI](https://msit.powerbi.com/groups/4b6248e6-e5a0-4d5d-b45f-551b5ba2405f/reports/70a60322-b363-4c07-9ea1-9b25175d5f0b/ReportSection35273e9749f1df2d4d24))
- ADX Dashboard ([ADT Integration Demo (azure.com)](https://dataexplorer.azure.com/dashboards/6840cd0a-625d-46be-b1b8-e31e531fd8f2?_startTime=2days&_endTime=now&Hospital=Arkham&Department=Psychiatry&Patients=patient2#796a38e3-13d8-469d-a1e1-9e8c94f48d18)) 
- Grafana ([Patient Monitoring with ADT - Grafana (azgrafana.io)](https://kustografanademo.scus.azgrafana.io/d/WgraFH1nk/patient-monitoring-with-adt?orgId=1&refresh=10s))
- TSI Javascript Controls ([Time Series Insights JavaScript SDK Examples (tsiclientsample.azurewebsites.net)](https://tsiclientsample.azurewebsites.net/))
- Kusto Trender ([Fully featured Trender](https://kustotrender.z6.web.core.windows.net/withplatform/exploreeventspayg.html))
- Seeq (https://seeq.atlassian.net/wiki/spaces/KB/pages/1318650038/Microsoft+Azure+Data+Explorer+(ADX)+Connector) 

## TSI Live Data 
At this point we should have a conversation with the customer on how we will connect to the hot path data flowing into TSI. Data will be flowing into TSI via EventHub or IoTHub so we will need to create a managed pipeline to ADX to ingest this data. 

To collect this data you will create another consumer group on EventHub and IoTHub and use that consumer group when setting up the ADX Managed Pipeline. There are two options that we will cover here on how to handle the ingestion in ADX. 

### Option 1: Historical Data and Hot Data in Same Table 

- Benefit: Having a single table simplifies the process for the customer
- Considerations
  - This almost certainly lead to duplicate data (Data you ingest from EventHub is still going to TSI so that data will make it’s way to the PT=Time folder than you are also ingesting)
  - Not as flexible as option 2 

### Option 2: Historical Data Table and Hot Data Table 
Ingest the two paths into two separate tables then use a union to bring the data together. Easiest way to explain is to walk through an example: 
- Historical data is ingested from the PT=Time and PT=Import folders and put into a table named TSIHistorical. As an example, we ingest data here all the way through 3/22
- Hot path data is ingested from Azure Event Hub and put int a table named TSIData. As an example, we initialize this connection at some point on 3/21
- Example query to union these two table together 

```kql
TSIData
| where TS >= datetime(2022-03-22) 
| union (TSIHistorical 
| where TS < datetime(2022-03-22) 
```

- Create a function that will execute this function. You can name the function the same thing as the hot path data to simplify for end user. For example, if I name the function TSIData now as an end user to me I’m querying one table (TSIData) and it has all the current and historical data. The function hides the union for them. 

## Pre-Migration 
Before migration of the historical data you will want to ensure the following: 
- Diagnostic Settings are enabled to send telemetry to Log Analytics. This allows monitoring of the historical ingestion as it occurs. 
- Access to PT=Time and PT=Import (if it exist) folders. We will need to generate a SAS token for both for use in the ingestion. 
- Unless it's a small environment we should scale up the cluster before initiating the LightIngest command. For example, 8+ node D14_v2 cluster. 

## Migrate Historical Data 
Follow the steps in the following document to migrate the environments historical data https://docs.microsoft.com/azure/time-series-insights/how-to-tsi-gen1-migration 

## Migrate Hot Path 
Add a consumer group to the Event Hub or IoT Hub used for the TSI Environment. Then utilize ADX One-Click Ingestion to setup the managed data pipeline 

[Use one-click ingestion to ingest data from event hub into Azure Data Explorer. | Microsoft Docs ](https://docs.microsoft.com/en-us/azure/data-explorer/one-click-event-hub)

[Azure Data Explorer One Click Ingestion for Azure Event Hub - YouTube](https://www.youtube.com/watch?v=-Wrr5B2pNYk&t=2s) 

## Post Data Migration 
- Verify all the data was migrated
  - Check data in Log Analytics for Successful Ingestion and verify it matches with data on blob for historical data. For example this will provide the number of blobs ingested: 

```kql
SucceededIngestion 
| where Table == 'TSITelemetry' 
| summarize dcount(IngestionSourcePath) 
```

  - Run some basic KQL queries to explore the data in ADX  

- Start building visualization based on their decision on which option to utilize 
- Configure RBAC on the ADX database to provide needed permissions 
