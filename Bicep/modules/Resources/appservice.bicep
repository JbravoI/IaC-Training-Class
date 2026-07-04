param tags object
param location string
param CAFPrefix string
param nameSeparator string

param appServicePlanName string = '${CAFPrefix}${nameSeparator}asp'
param webAppName string = '${CAFPrefix}${nameSeparator}app221'
param netFrameworkVersion string = 'v8.0'   // Windows .NET version
param runtimeStack string = '.NET|8-lts'    // used only if osType == 'linux'
param osType string = 'windows'

var isLinux = osType == 'linux'

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
  kind: isLinux ? 'linux' : 'app'
  properties: {
    reserved: isLinux
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  tags: tags
  kind: isLinux ? 'app,linux' : 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: isLinux ? runtimeStack : null
      netFrameworkVersion: isLinux ? null : netFrameworkVersion
      alwaysOn: false  // Not supported on Free tier
    }
    httpsOnly: true
  }
}

output appServicePlanId string = appServicePlan.id
output webAppUrl string = 'https://${webAppName}.azurewebsites.net'
