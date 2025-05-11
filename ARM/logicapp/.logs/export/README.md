# Welcome to your new Standard logic app workflow

This automatically generated Standard logic app workflow was created by exporting the following Consumption logic app workflows:

- /subscriptions/548e8528-ab98-4760-808e-e79416afe755/resourceGroups/simpletest123321_group/providers/Microsoft.Logic/workflows/simpletest123321

## Get started with your new logic app

Before you can use or work with your new logic app, you must review and complete the following tasks:

- 

To review the export validation results and summary, find the '.logs/export' folder.

## Infrastructure

Included in your Logic App Workflow are some sample ARM templates you can use as a start to getting your Logic App Devop ready.

To help you get your new Standard logic app ready for DevOps, your new logic app project in Visual Studio Code includes sample Azure Resource Manager templates (ARM templates) in your project's **.development/deployment** folder:

| ARM template | Description |
|--------------|-------------|
| **LogicAppStandardConnections.template.json** | Use this sample template to create your Azure-managed API connections. The template doesn't include any secrets, so if a connector doesn't clone connections from their counterpart in Consumption logic app workflows, you have to manually authenticate the connection after creation. |
| **LogicAppStandardInfrastructure.template.json** | Use this sample template to create other assets and resources necessary to run your Standard logic app in the cloud, such as the Workflow Service plan, Standard logic app resource, and Azure storage account. To fit your specific scenarios, you're encouraged to customize this template for your needs. |
|||

## Resources

The following documentation resources can also help you get started with Standard logic apps and follow best practices to manage your workflows:

- [Single-tenant versus multi-tenant and integration service environment](https://docs.microsoft.com/azure/logic-apps/single-tenant-overview-compare)