# TSI to ADX

## Description
This repo contains collateral that can be leveraged by customers to migrate from TSI to ADX. 

The Microsoft **Cloud Migration Factory** rogram accepts **Lakehouse** [nominations](https://aka.ms/cmf) to help our TSI customers migrate to ADX by providing hands-on keyboard resources at no-cost to the customer. The hands-on keybard resource and customer can leverage the tools & collateral shared in this repo. Customres can contact their account team Data & AI Specialist or Cloud Solution Architect to submit a nomination. 


## Introduction
TSI to ADX Migration workshop is a 1/2-day proctor-led that explains how-to migrate through a series of presentations, demos and tooling. Azure Time Series Insights (TSI) service will no longer be supported [after March 2025](https://aka.ms/tsi2adx). Consider migrating existing TSI environments to alternative solutions as soon as possible. The workshop will share a look at the feature comparisons with ADX and help execute migration steps.

- Slide Deck ([PPTx](PPTs/TSI%20to%20ADX%20-%20Lessons.pptx), [PDF](PPTs/TSI%20to%20ADX%20-%20Lessons.pdf))
- [Demos](PPTs/Demos.md)
- [Agenda](PPTs/Agenda.md)
- [Map](PPTs/Map.md)

For additional details, refer to the **Page 5** in [Datasheet](PPTs/Datasheet-CIP-ADX-Onboarding.pdf)

## Resources
- https://aka.ms/tsi2adx 
- https://aka.ms/adx.iot
- https://aka.ms/adx.free
- [Kusto Update Policy](https://learn.microsoft.com/azure/data-explorer/kusto/management/updatepolicy)
- [Json Mapping](https://learn.microsoft.com/azure/data-explorer/kusto/management/json-mapping)
- [.create table command](https://learn.microsoft.com/azure/data-explorer/kusto/management/create-table-command)
- [ADX Ingestion Overview](https://learn.microsoft.com/en-us/azure/data-explorer/ingest-data-overview)
- [.show extents](https://learn.microsoft.com/azure/data-explorer/kusto/management/show-extents)
- [How to ingest data with REST API](https://learn.microsoft.com/azure/data-explorer/kusto/api/netfx/kusto-ingest-client-rest) (not required for this migration)
- [Streaming ingestion HTTP request](https://learn.microsoft.com/azure/data-explorer/kusto/api/rest/streaming-ingest) (not required for this migration)
- [Configure streaming ingestion on ADX](https://learn.microsoft.com/azure/data-explorer/ingest-data-streaming?tabs=azure-portal%2Ccsharp)
- [Auth over HTTPS](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/api/rest/authentication) (not required for this migration)
- Kusto SDK examples using .Net SDK via [PowerShell](https://github.com/Azure/ADXIoTAnalytics/tree/main/assets/OfficialDemos/Others/PowerShell)
- https://aka.ms/learn.kql
- https://aka.ms/mustlearnkql
- [Kusto.Ingest client interfaces and factory classes](https://learn.microsoft.com/azure/data-explorer/kusto/api/netfx/kusto-ingest-client-reference#class-kustoingestionproperties)

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
