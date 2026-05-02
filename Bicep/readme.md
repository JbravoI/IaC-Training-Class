
subscription -> ResourceGroup -> Resource (Azure Format)

How the code works

Main.bicep = deploys the resource group and Submodule
ResourceGroup.bicep = resource group code
submodule.bicep = Controls your modules
Module folder -> Resouces Folder -> appservice.bicep
appservice.bicep = It has the code for your app service and App service plan

-----Assignment
-create module for networking (virtual_network.bicep/subnet)
-create module for virtual_Machine (virtual_machine.bicep )
- link your vm and vnet to your submodule.bicep file