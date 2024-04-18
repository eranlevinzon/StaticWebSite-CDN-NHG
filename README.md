# static-website-cdn

This project aims to showcase the deployment of a Static Web Site on the Azure cloud, complete with a CDN endpoint configured for accessing the website via the following URL.
https://endpoint-lmvdj3nf22ikm.azureedge.net/

Bicep modules have been developed for resource deployment.
1. storageaccount.bicep
    This file orchestrates the deployment of an Azure Storage account, followed by the configuration necessary to support static website hosting. Since enabling static website hosting directly within Bicep or an ARM template isn't feasible, a deployment script is employed to activate this functionality.

2. cdn.bicep 
   This file initiates the deployment of a CDN Profile and Endpoint.
3. main.bicep
   The modules mentioned above are invoked in the Main.Bicep file.

Parameters:
Three environments—Dev, Stage, and Prod—are established, with the following files utilized for passing parameters to the Bicep file. These can be expanded in the future as needed to incorporate additional resources.
 1. dev.parameters.json
 2. stage.parameters.json
 3. prod.parameters.json


 Pipline Files:
 1. azure-pipeline.yaml
    Within this pipeline, three environments—Dev, Stage, and Prod—are established, each employing its own resource group. Three distinct variable groups are utilized to transmit pipeline variables (ClientId, Client Secret, and Tenant ID) of a Service Principle created for this purpose.
     1. static-website-variable-group-dev
     2. static-website-variable-group-stage
     3. static-website-variable-group-prod 
 2. azure-deploy-template.yaml

 Power Shell Script File (Pester Tests):
 1. verify-website.tests.ps1 
    A PowerShell script file has been generated to execute Pester Tests, which validate the Storage Account, CDN Profile, CDN Endpoint, Static Website, and its content.
