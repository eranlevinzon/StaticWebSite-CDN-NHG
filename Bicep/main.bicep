@description('Location for all resources.')
param location string = resourceGroup().location

@description('Envioronment')
param environment string

module storageAccount './modules/storageaccount.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    environment: environment
    location: location
  }
}

module cdn './modules/cdn.bicep' = {
  name: 'cdnDeployment'
  params: {
    storageAccountHostName: storageAccount.outputs.storageAccountHostName
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output storageEndpoint string = storageAccount.outputs.storageAccountHostName
output cdnEndpointHostName string = cdn.outputs.hostName
output cdnOriginHostHeader string = cdn.outputs.originHostHeader
