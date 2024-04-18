param(
    [string]$WebsiteHostName,
    [string]$endpointName,
    [string]$resourceGroupName,
    [string]$cdnProfileName,
    [string]$storageAccountName
)

# Test to validate Storage Account.
Describe "Storage Account Validation" {    
    It "Storage Account exists" {
        $storageAccountExists = az storage account show --name $storageAccountName --resource-group $resourceGroupName --query "name" --output tsv
        $storageAccountExists | Should -Be $storageAccountName
    }
}

# Test to validate CDN Profile.
Describe "CDN Profile Validation" {  

    It "CDN Profile exists" {
        Write-Host "cdnProfileName: $cdnProfileName"
        $cdnProfileExists = az cdn profile show --name $cdnProfileName --resource-group $resourceGroupName --query "name" --output tsv
        Write-Host "cdnProfileExists: $cdnProfileExists"
        $cdnProfileExists | Should -Be $cdnProfileName
    }
}

# Test to validate CDN Endpoint.
Describe "CDN Endpoint Validation" {    
    It "CDN Endpoint exists" {
        Write-Host "cdnProfileName: $cdnProfileName"
        Write-Host "cdnProfileEndPoint: $endpointName"
        $endpointExists = az cdn endpoint list --profile-name $cdnProfileName --resource-group $resourceGroupName --query "[0].hostName" --output tsv
        $endpointExists | Should -Be $endpointName
    }
}

# Test to validate Static WebSite and its content.
Describe 'static-website' {
    Write-Host "WebsiteHostName: $endpointName"  
    It 'Serves pages over https' {
        Invoke-WebRequest -Uri "https://${endpointName}" -UseBasicParsing |
        Select-Object -ExpandProperty StatusCode |
        Should -Be 200
    }

    It 'Serves Index page' {
        Invoke-WebRequest -Uri "https://${endpointName}/index.html" -UseBasicParsing |
        Select-Object -ExpandProperty StatusCode |
        Should -Be 200
    }

    It 'Serves 404 page' {
        Invoke-WebRequest -Uri "https://${endpointName}/404.html" -UseBasicParsing |
        Select-Object -ExpandProperty StatusCode |
        Should -Be 200
    }
}

