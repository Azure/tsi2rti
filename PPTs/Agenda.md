## TSI to ADX Migration
Duration: 1/2 Day


| Links to env in Ibiza	(MS-Internal) | Total size of Cold Parquet blobs (compressed) | Storage Account |
|--- |--- |--- |
| [env-xtluse2s88-pusher-0](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/xtluse2s88-pusher-rg/providers/Microsoft.TimeSeriesInsights/environments/env-xtluse2s88-pusher-0/overview) | 46 GB | [xtluse2s88pushersa](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/xtluse2s88-pusher-rg/providers/Microsoft.Storage/storageAccounts/xtluse2s88pushersa/overview) |
|[env-ingress-stress-l1-s03-0](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/Perftest03/providers/Microsoft.TimeSeriesInsights/environments/env-ingress-stress-l1-s03-0/overview) | 35 TB| [l1stressteststorages03](https://ms.portal.azure.com/#@microsoft.onmicrosoft.com/resource/subscriptions/4780209c-aab1-443f-b575-45461519f1af/resourceGroups/Perftest03/providers/Microsoft.Storage/storageAccounts/l1stressteststorages03/overview) |

MS-Internal only [join SG](https://idwebelements/GroupManagement.aspx?Group=adxdemoenv&Operation=join) while on Corp VPN.

[TSI Explorer (azure.com)](https://insights.timeseries.azure.com/?endpoint=api.crystal-dev.windows-int.net) > See [Sample Demo](https://insights.timeseries.azure.com/demo) env for front-end experience if needed.

[Map](./Map.md)
 
| Lesson | Topics | Est. Minutes | Person | Completion Date |
|---|---|---|---|---|
|Lesson 1 | **Why TSI to ADX migration?** | 30 | Hiram | 5/31/22 |
||Explain the announcement||||
||Explain the migration path, options, timelines. What is possible and what is not||||
||Demo 1 (Understanding TSI environment)||||
|| * Show how to gather specific details of the TSI environment that is needed to plan the migration (blob folder, lateness in data, etc.). * Blob storage folder, give access||||
||||||| 
|Lesson 2|**Understanding ADX > Overview module of ADX for IoT**|60| Hiram| 5/31/22 |
||Explain that ADX is the best suited option.||||
||Explain the differences between TSI and ADX. Highlight the "breaking" differences and how these will be handled|
||Demo 2 (ADX and how it works?) > option [M02-Demo4-IoT.kql](https://github.com/Azure/ADXIoTAnalytics/blob/main/assets/OfficialDemos/M02-Demo4-IoT.kql)||||
|| * Show IoT demo of ADX explaining what you can do with ADX. IoT demo must include some of the timeseries analysis functions that TSI provided. * Emphasis on Time Series render & dashboard||||
||||||| 
Lesson 3	Migrating from TSI to ADX	 60	Achan, Ismael, El Amin	6/15/22
 	Walkthrough the key steps of migrating from TSI to ADX. https://docs.microsoft.com/en-us/azure/time-series-insights/how-to-tsi-gen2-migration 
 		 
 	Explain what actions customers need to take to complete the migration. Explain the key attention items. Explain the automation options available at each step	 		 
 	Demo 3 (Setting up migration tooling/services)			
 	•	Show the relevant Azure services that need to be setup before the actual migration can occur (including ADX, ADF, Automation Accounts, Log Analytics for monitoring, LightIngest, Visualization (PBI, Azure Grafana, etc.)			
	Demo 4 (Migrating from TSI to ADX)			
	•	Show the historical data migration automation
•	Show how to handle migration of integration points (ingestion, visualization and REST APIs)			
				
Lesson 4	Finalizing the migration	45	Devang	6/15/22
	Explain how to complete and finalize the migration			
	Explain how long TSI and ADX need to run in parallel, how to plant the cutover, actions needed to cut over, user migration, updating DNS entries, etc.			
	Demo 5 (Finalizing the migration)			
	•	Show what changes need to be made for cutover from TSI to ADX.			
 

