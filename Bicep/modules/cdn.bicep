@description('The host name of the storage account.')
param storageAccountHostName string

// Creating Profile Name and End Point Name  using Unique String function from ResourceGroup ID.
var profileName = 'cdn-${uniqueString(resourceGroup().id)}'
var endpointName = 'endpoint-${uniqueString(resourceGroup().id)}'

resource cdnProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: profileName
  location: 'global'
  tags: {
    displayName: profileName
  }
  sku: {
    name: 'Standard_Verizon'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  parent: cdnProfile
  name: endpointName
  location: 'global'
  tags: {
    displayName: endpointName
  }
  properties: {
    originHostHeader: storageAccountHostName
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    contentTypesToCompress: [
      'text/plain'
      'text/html'
      'text/css'
      'application/x-javascript'
      'text/javascript'
    ]
    isCompressionEnabled: true
    origins: [
      {
        name: 'origin1'
        properties: {
          hostName: storageAccountHostName
        }
      }
    ]
  }
}

output hostName string = endpoint.properties.hostName
output originHostHeader string = endpoint.properties.originHostHeader
