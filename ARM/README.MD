You cannot deploy a Resource Group inside an ARM template when deploying at resource group scope.

ARM templates are usually deployed into a resource group
To create a resource group, you must use subscription-level deployment



✅ Resource Group (subscription-level template)
✅ Storage Account (RG-level template)
✅ Virtual Machine (RG-level template)