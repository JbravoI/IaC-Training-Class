// Set the scope to the subscription
targetScope = 'subscription'

// Configure Customer Prefix
param CAFPrefix string
param nameSeparator string 
param resourceGroupName string
param location string
param tags object




// App Service
module appservice './Resources/appservice.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'appservice'
  params: {
    nameSeparator: nameSeparator
    CAFPrefix: CAFPrefix
    location: location
    tags: tags
    skuName: 'S1'
  }
  dependsOn: [
  ]
}

//Virtual Network
module v............ './Resources/virtualNetwork.bicep' = {

}

//Public Ip
module v............ './Resources/publicIp.bicep' = {

}

//Virtual Machine
module v............ './Resources/virtualMachine.bicep' = {

}
