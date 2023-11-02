# Demos E2E

- All official demo scripts end-to-end.
- [Map](./Map.md)


# Lesson 1 
## Demo 1 - Understanding TSI Env
1. Understand the TSI Env.
2. Gather details (blob folder, lateness in data)
3. Give storage blob read access 

TSI Gen1 Demo envs: https://insights.timeseries.azure.com/demo

TSI Gen2 Demo envs: 
1. [env-xtluse2s88-pusher-0](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/xtluse2s88-pusher-rg/providers/Microsoft.TimeSeriesInsights/environments/env-xtluse2s88-pusher-0/overview) (46 GBs compressed)
   - Corresponding [storage](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/xtluse2s88-pusher-rg/providers/Microsoft.Storage/storageAccounts/xtluse2s88pushersa/overview)
2. [env-ingress-stress-l1-s03-0](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/Perftest03/providers/Microsoft.TimeSeriesInsights/environments/env-ingress-stress-l1-s03-0/overview) (35 TBs compressed)
   - Corresponding [storage](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/Perftest03/providers/Microsoft.Storage/storageAccounts/l1stressteststorages03/overview)


# Lesson 2 
## Demo 2 - ADX and How it works
1. IoT Demo doing Timeseries analysis.
2. Emphasis on `make-series`, `render` and dashboard.

## Module 2.1 - IoT (Reused from CIP: ADX for IoT Analytics)
1. MS-Internal only, if needed, [join this SG](https://idwebelements/GroupManagement.aspx?Group=adxdemoenv&Operation=join) to get access. Req. MSFTVPN, see more: [here](https://dev.azure.com/CEandS/Azure-Data-Explorer/_git/ADX-with-IoT-Analytics?path=/Demos/Backpocket/IoTCustomerStoriesWithADX/readme.md).
3. For this demo place emphasis on: 
   * Thermostat data
   * JSON
   * Render & Pin to dashboard. (toggle between both)
   * Series fill linear
   * Forecast
   * Anomalies
   * [ADX Dashboard](https://dataexplorer.azure.com/dashboards/474edab9-00cf-4b9e-b785-8669b90c01e4?startTime=24hours&endTime=now&Device_Id=637085868243706792) & [Grafana](https://kustografanademo.scus.azgrafana.io/d/RmU02Dtnz/iot-demo-dashboard?orgId=1&var-Devices=1iqisxd5v6e&var-Devices=1k4gso7qv5y&from=1637640911640&to=1637684111640)
   * Materialized Views
   * External Tables

### Run Script: [M02-Demo4-IoT.kql](https://github.com/Azure/ADXIoTAnalytics/blob/main/assets/OfficialDemos/M02-Demo4-IoT.kql) 


# Lesson 3
## Demo 3 - Setup migration tooling
1. Show the relevant Azure services that need to be setup before the actual migration can occur (including ADX, ADF, Automation Accounts, Log Analytics for monitoring, LightIngest, Visualization (PBI, Azure Grafana, etc.) 

## Demo 4 - Migrating from TSI to ADX
1. Show the historical data migration automation 
2. Show how to handle migration of integration points (ingestion, visualization and REST APIs) 

## Demo Scripts
### PowerShell - LightIngest.exe CLI Tool** (Preferred - Recommneded) 
- [TSItoADXIngestion.ps1](./gen2/TSItoADXIngestion.ps1)

### ADF (Azure Data Factory Pipeline)
- https://dev.azure.com/CEandS/Azure-Data-Explorer/_git/ADX-Onboarding?path=/Demos/Demo3/Pipelines


# Lesson 4
## Finalizing the migration
1. Show what changes need to be made for cutover from TSI to ADX.

### Demo 5 - Visualization Options
1. Power BI: [Connected Devices - Power BI​](https://msit.powerbi.com/groups/4b6248e6-e5a0-4d5d-b45f-551b5ba2405f/reports/70a60322-b363-4c07-9ea1-9b25175d5f0b/ReportSection35273e9749f1df2d4d24)
2. ADX Dashboard: [ADT Integration Demo (azure.com)](https://dataexplorer.azure.com/dashboards/6840cd0a-625d-46be-b1b8-e31e531fd8f2?_startTime=2days&_endTime=now&Hospital=Arkham&Department=Psychiatry&Patients=patient2#796a38e3-13d8-469d-a1e1-9e8c94f48d18) ​
3. Grafana: [Patient Monitoring with ADT - Grafana (azgrafana.io)​](https://kustografanademo.scus.azgrafana.io/d/WgraFH1nk/patient-monitoring-with-adt?orgId=1&refresh=10s)
4. TSI JavaScript Controls: [Time Series Insights JavaScript SDK Examples (tsiclientsample.azurewebsites.net)](https://tsiclientsample.azurewebsites.net/)​
5. Seeq: [Microsoft Azure Data Explorer (ADX) Connector - Seeq Knowledge Base - Confluence (atlassian.net)](https://seeq.atlassian.net/wiki/spaces/KB/pages/1318650038/Microsoft+Azure+Data+Explorer+(ADX)+Connector)
