# TSI to RTI (Real-Time Intelligence)
Using Fabric Eventhouse or Azure Data Explorer

## Description
This repo contains collateral that can be leveraged to migrate from TSI to Microsoft Fabric Real-Time Intelligence (RTI) or Azure Data Explorer (ADX). 

The Microsoft **Cloud Migration Factory** program accepts customer [nominations](https://aka.ms/cmf) to help our TSI customers migrate to Fabric RTI or ADX, by providing hands-on keyboard resource(s) at no-cost to the customer. Hands-On keyboard resource(s) are assigned for a period of 6-8 weeks with an agreed scope. The hands-on keybard resource and customer can leverage the tools & collateral shared in this repo to complete the migration. Customers can contact their account team Data & AI Specialist, Customer Success Account Manager (CSAM) or Cloud Solution Architect (CSA) to submit a nomination. Additionally, you can use this form [TSI2FabricMigrationHelp](https://aka.ms/TSI2FabricMigrationHelp) to request help directly from the CAT team and Product Group.  

## Readiness
A workshop can be proctored by a Microsoft representative or SME, as a 1/2-day remote-session, to explain & demonstrate how-to migrate end-to-end. Using a mix of presentations, demos and available tooling, the workshop upskill attendies why they should migrate & how. Azure Time Series Insights (TSI) service will be retired on [July 7th of 2024](https://learn.microsoft.com/azure/time-series-insights/migration-to-fabric). Consider migrating existing TSI environments to alternative solutions as soon as possible. The workshop will share a look at the feature comparisons with ADX and help execute migration steps.

- [CSU CMF Analytics - Real Time Intelligence](PPTs/CSU%20CMF%20Analytics%20-%20Real%20Time%20Intelligence.pdf)
- [TSI to ADX - Lessons](PPTs/TSI%20to%20ADX%20-%20Lessons.pptx)
- [Demos](PPTs/Demos.md)
- [Agenda](PPTs/Agenda.md)
- [Map](PPTs/Map.md)
- [Docs](https://learn.microsoft.com/azure/time-series-insights/migration-to-fabric)

For additional details, refer to the **Page 5** in [Datasheet](PPTs/Datasheet-CIP-ADX-Onboarding.pdf)

Additional links available as [resources](resources.md).

## Accelerated Retirement Notice
### Azure Time Series Insights is retiring on 7 July 2024 – transition to Azure Data Explorer 

Microsoft's leadership emphasizing priority on security has decided to accelerate the retirement of the Time Series Insights service to **7 July 2024**.

Please transition to using Azure Data Explorer by 7 July 2024. On the retirement, date Azure Time Series Insights will stop functioning and will be inaccessible.

We encourage you to make the switch sooner to gain the richer benefits of Azure Data Explorer. In addition to the current features you already use, here’s a comparison between Azure Time Series Insights and Azure Data Explorer:

| Features	| Time Series Insights |	Azure Data Explorer |
| --- | --- | --- |
| Data ingestion	| Limited to 1MB/s	| No limits on ingestions (scalable), 200 MB/s/node on a 16-core machine in ADX cluster.|
| Data Querying	| TSQ | KQL, SQL |
| Data Visualization | TSI Explorer, PBI | PBI, Azure Data Explorer Dashboards, Grafana, Kibana and other visualization tools using ODBC/JDBC connectors |

### Required action 
Review our [pricing](https://azure.microsoft.com/pricing/details/data-explorer/) and then [transition](https://learn.microsoft.com/azure/time-series-insights/migration-to-adx) to Azure Data Explorer by **7 July 2024**. Use the [Azure Data Explorer Cost Estimator](https://dataexplorer.azure.com/AzureDataExplorerCostEstimator.html) for a price estimation. After 7 July 2024, Azure Time Series Insights won’t be supported. 

### Notice of FedRAMP certification changes 
Since Azure Time Series Insights is on a retirement schedule, the offering no longer receives the updates required to maintain the latest FedRAMP High compliance requirements. The offering can no longer be considered FedRAMP High compliant.

### Help and support 
If you have questions, get answers from community experts in [Microsoft Q&A](https://learn.microsoft.com/answers/tags/188/azure-time-series-insights). If you have a support plan and you need technical help, please create a [support request](https://portal.azure.com/#view/Microsoft_Azure_Support/HelpAndSupportBlade/~/overview). 
1.	Under Issue type, select Technical.
2.	Under Subscription, select your subscription.
3.	Under Service, select My services, then select Time Series Insights
4.	Under Summary, type a description of your issue.
5.	Under Problem type, select Migration to Azure Data Explorer

Learn more about service retirements that may impact your resources in the [Azure Retirement Workbook](https://aka.ms/ServicesRetirementWorkbook). Please note that retirements may not be visible in the workbook for up to two weeks after being announced.



## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
