# Deploy Suse Enterprise Linux Server (SLES) 12 and Chef Server 12

| Deploy to Azure  | Author                          | Template Name   |
|:-----------------|:--------------------------------| :---------------| :---------------|
| <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstarkfell%2Fazure-quickstart-templates%2Fmaster%2Fdeploy_suse_and_chef%2Fdeploy_suse_and_chef%2FTemplates%2Fdeploy_suse_and_chef.json" target="_blank"><img src="http://azuredeploy.net/deploybutton_small.png"/></a> | [starkfell](https://github.com/starkfell) | Learn Chef (https://github.com/starkfell/azure-quickstart-templates/tree/master/deploy_suse_and_chef)

This template provisions an environment in Azure for learning Chef.
 
 The following VMs are deployed with their own publicly accessible FQDN's for SSH Access respectively. Additional Software Components listed below are installed during Post VM Deployment.
 - Ubuntu Server 14.04 running Chef Server 12
   - Chef Management Console
   - Chef Reporting
 - Suse Enterprise Linux Server (SLES) 12
   - Chef Client 12.4.3
   - Chef DK 0.8.0

 
All of the VMs deployed in this template are **Standard_D1**.

The following Parameter Values **MUST** be **unique to your region** in Azure! If they currently exist in the region you are deploying this template into the deployment will fail!

 - **CONTOSOSUSESTORAGENAME**
 - **SUSESRVPUBIPDNSNAME**
 - **CHEFSRVPUBIPDNSNAME**

 
This template requires the following parameters which are preconfigured:


| Name             | Description                     |
|:-----------------| :--------------------------------|
| LOCATION | Location name where the corresponding Azure artifacts will be created |
| ADDRESSPREFIX | Default Address Prefix for the entire Environment |
| SUSESUBNETPREFIX | Address Prefix for both Hosts |
| CONTOSOSUSESTORAGENAME | The Name of the Storage Container being deployed |
| CONTOSOSUSESTORAGETYPE | The type of Storage being deployed |
| SUSESRVNAME | Name of the SLES Server |
| CHEFSRVNAME | Name of the Chef Server |
| SUSESRVADMINUSERNAME | Admin Username of the SLES Server |
| CHEFSRVADMINUSERNAME | Admin Username of the Chef Server |
| SUSESRVADMINPASSWORD | Admin Password of the SLES Server |
| CHEFSRVADMINPASSWORD | Admin Password of the Chef Server |
| SUSEOSVERSION | Suse OS Version that the SLES Server is running |
| UBUNTUOSVERSION | Ubuntu OS Version that the Chef Server is running |
| SUSESRVPUBIPDNSNAME | Publicly accessible FQDN associated with the SLES Server|
| CHEFSRVPUBIPDNSNAME | Publicly accessible FQDN associated with the Chef Server |
| SUSESRVNICIPADDRESS | Static IP Address of the SLES Server NIC Card |
| CHEFSRVNICIPADDRESS | Static IP Address of the Chef Server NIC Card |
| ASSETLOCATION | Default Location of all Resources required to Deploy this Azure Template |
