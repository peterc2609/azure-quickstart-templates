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

The following Parameter Values **MUST** be **unique to your region** in Azure! If they exist in the **Azure Region** you are deploying to, the deployment will fail!

 - **CONTOSOSUSESTORAGENAME**
 - **SUSESRVPUBIPDNSNAME**
 - **UBUNTUSRVPUBIPDNSNAME**

There are zero Variables in this Template and all Parameter Values are preconfigured.

| Name             | Description                      |
|:-----------------| :--------------------------------|
| LOCATION | Location name where the corresponding Azure artifacts will be created |
| VNETNAME | Name of the Virtual Network where all of the Resources are being deployed |
| ADDRESSPREFIX | Default Address Prefix for the entire Environment |
| LINUXSUBNETPREFIX | Linux Subnet Prefix |
| LINUXSUBNETNAME | Linux Subnet Name |
| CONTOSOLINUXSTORAGENAME | Name of the Storage Account where the Resources are being deployed |
| CONTOSOLINUXSTORAGETYPE | The type of Storage being deployed |
| SUSESRVNAME | The Name of the Suse Server|
| UBUNTUSRVNAME | The Name of the Ubuntu Server |
| SUSESRVADMINUSERNAME | Admin Username of the Suse Server |
| UBUNTUSRVADMINUSERNAME | Admin Username of the Ubuntu Server |
| SUSESRVADMINPASSWORD | Admin Password of the Suse Server |
| UBUNTUSRVADMINPASSWORD | Admin Password of the Ubuntu Server |
| SUSEIMAGEPUBLISHER | The Suse Image Publisher of the Image being used for the VM |
| SUSEIMAGEOFFER | The Suse Image Offer of the Image being used for the VM |
| SUSEOSSKU | The Suse SKU number of the version being deployed |
| SUSEOSVERSION | A fully patched image of the Suse OS version |
| UBUNTUIMAGEPUBLISHER | The Ubuntu Image Publisher of the Image being used for the VM |
| UBUNTUIMAGEOFFER | The Ubuntu Image Offer of the Image being used for the VM |
| UBUNTUOSSKU | The Ubuntu SKU number of the version being deployed |
| UBUNTUOSVERSION | A fully patched image of the Ubuntu OS version |
| SUSEOSDISKNAME | The Name of the Suse Server OS Disk |
| UBUNTUOSDISKNAME | The Name of the Suse Server OS Disk |
| SUSEVMSIZE | The Size of the Suse Server VM being deployed in Azure |
| UBUNTUVMSIZE | The Size of the Ubuntu Server VM being deployed in Azure |
| SUSESRVPUBIPDNSNAME | Publicly accessible FQDN associated with the Suse Server|
| UBUNTUSRVPUBIPDNSNAME | Publicly accessible FQDN associated with the Ubuntu Server |
| SUSESRVNICIPADDRESS | Static IP Address of the Suse Server NIC Card |
| UBUNTUSRVNICIPADDRESS | Static IP Address of the UBuntu Server NIC Card |
| INSTALLCHEFCLIENTSCRIPTURI | The location of the custom Chef Client Installation Script for the Suse Server VM |
| INSTALLCHEFCLIENTSCRIPTNAME | The Name of the Chef Client Installation Script |
| INSTALLCHEFSERVERSCRIPTURI | The location of the custom Chef Server Installation Script for the Ubuntu Server VM |
| INSTALLCHEFSERVERSCRIPTNAME | The Name of the Chef Server Installation Script |
| CHEFORGANIZATION | The Name of the Chef Organization being created |
| ASSETLOCATION | Default Location of all Resources required to Deploy this Azure Template |
