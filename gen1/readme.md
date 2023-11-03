# TSI Gen1 Tools

## [script1-loop30s.ps1](./script1-loop30s.ps1)
- Migrates historical out of TSI Gen1 using Data Access REST-API by looping through the time-range in 30 seconds intervals. This helps us deal with the 10K row limit of the Rest-API per request.
- Ingests directly into ADX using Kusto SDK in JSON format using Batching ingestion. See [pre-req instructions](https://github.com/Azure/ADXIoTAnalytics/tree/main/assets/OfficialDemos/Others/PowerShell#pre-reqs) to install PS7 and SDK.
- Define your variables at the top of the script accoridng your enviroment.
- Uses App Registration service principal secret to authenticate to TSI. Please grant it Data Access permissions to the source TSI env.
- Uses Federated Authentication to authenticate to ADX. May require setting the ADX cluster Security setting to multi-tenant depending on your enviroment that's launching the script, and granting Ingestor permission on the Database, see example to add access in [kqlcommands.kql](./kqlcommands.kql).
- Loop frequency is set to 30s in consideration to large TSI production enviroments with millions of rows per day.

### Variables to define before running the script
- **AppId** - If you have an application registered, you will get the AppId under overview of the application. If you don't have app registered, follow the instructions to create an application registration [Register an Application](https://learn.microsoft.com/en-us/azure/time-series-insights/time-series-insights-authentication-and-authorization#application-registration)
- **SecretId** - You can generate the secret by following the instructions [Generate secret](https://learn.microsoft.com/en-us/azure/industry/training-services/microsoft-community-training/frequently-asked-questions/generate-new-clientsecret-link-to-key-vault)
- **TenantId** - In Azure Portal, search for Microsoft Entra ID, you will see Tenant ID in the Basic information section of the Overview screen.
- **Environment_FQDN** - It is TSI environment full qualified domain name. Go to your TSI environment, under Overview you will get this.
- **ADXuri** - Go to your ADX cluster, under Overview you will get Ingestion URI.
- **db** - Name of the database in ADX cluster
- **t** - Name of the table where you want to dump the historical data.
- **pkgroot** - This is the local path where you installed the **Microsoft.Azure.Kusto.Tools** SDK.
- **startDate** and **endDate** - Here the script loops backwards in time. Start time should be greater than End time. For ex, if you specify start time as "2023-10-31T00:00:00" and end time as "2023-10-01T00:00:00", It will loop backwards for each 30 seconds and get the data from TSI environment till end date Oct 01 2023 from start date Oct 31 2023.
  

## [script2-countbyday.ps1](./script2-countbyday.ps1)
- Returns an aggregate count of rows for a time-range period, such as a month, so we can gage how big is the volume of historical rows required to migrate.
- This helps us determine the size of the loop (interval) in script1 to stay within the limits of the TSIGen1 REST-API per request.
- Script1 loops by 30s considering an output of Script2 that has +24M of rows per day.
- For smaller envs Script1 can be changed for larger frequency ie. every several hours, or per day, but its not required thurs far.

