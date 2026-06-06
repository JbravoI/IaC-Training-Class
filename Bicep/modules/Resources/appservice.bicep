param tags object
param location string
param CAFPrefix string
param nameSeparator string

param appServicePlanName string = '${CAFPrefix}${nameSeparator}asp'
param webAppName string = '${CAFPrefix}${nameSeparator}app221'
param runtimeStack string = 'NODE|18-lts'
param osType string = 'windows'

// App Service Plan - Free Tier (F1)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: 'F1'
    tier: 'Free'
    capacity: 1
  }
  kind: osType
  properties: {
    reserved: osType == 'linux'
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  tags: tags
  kind: osType
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: osType == 'linux' ? runtimeStack : null
      nodeVersion: osType == 'windows' ? '~18' : null
      alwaysOn: false  // ❌ Not supported on Free tier
    }
    httpsOnly: true
  }
}

output appServicePlanId string = appServicePlan.id
output webAppUrl string = 'https://${webAppName}.azurewebsites.net'
