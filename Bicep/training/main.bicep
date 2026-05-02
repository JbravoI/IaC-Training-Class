// Set the scope to the subscription
targetScope = 'subscription'

param subscriptionId string
param environmentName string
param location string
param customerName string
param nameSeparator string

// Configure Customer Prefix
param CAFPrefix string = '${customerName}${nameSeparator}${environmentName}${nameSeparator}eus'

// Resource Group Name
param resourceGroupName string = '${CAFPrefix}${nameSeparator}rg'

// Default Tag Set
param tags object = {
  ModifiedBy: ''
  ModifiedDateTime: ''
  Startup: 'NA'
  Shutdown: 'NA'
  AutoScale: 'NA'
  Monitor: 'NA'
  CostCategory: 'Network'
  Environment: environmentName
  Customer: customerName
}

module resourceGroup '../modules/resourceGroup.bicep' = {
  scope: subscription(subscriptionId)
  name: 'resourceGroup'
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

module submodule '../modules/submodule.bicep' = {
  scope: subscription(subscriptionId)
  name: 'submodule'
  params: {
  resourceGroupName: resourceGroupName
  nameSeparator: nameSeparator
  CAFPrefix: CAFPrefix
  location: location
  tags: tags
  }
  dependsOn: [
    resourceGroup
  ]
}
