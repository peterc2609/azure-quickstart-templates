# Learn Chef Deployment

| Deploy to Azure  | Author                          | Template Name   |
|:-----------------|:--------------------------------| :---------------| :---------------|
| <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstarkfell%2Fazure-quickstart-templates%2Fmaster%2Flearn_chef%2Fazuredeploy.json" target="_blank"><img src="http://azuredeploy.net/deploybutton_small.png"/></a> | [starkfell](https://github.com/starkfell) | Learn Chef (https://github.com/starkfell/azure-quickstart-templates/tree/master/learn_chef)

This template provisions an environment in Azure for learning Chef.
 
 The following VMs are deployed with their own publicly accessible FQDN's for RDP and SSH Access respectively.
 - Ubuntu Server 14.04 running Chef Server 12
 - Windows Server 2012 R2 running as a Domain Controller
 - Windows Server 2012 R2 non-domain-joined with ChefDK Installed
 - Windows Server 2012 R2 non-domain-joined for use as a Sandbox

All of the VMs deployed in this template are **Standard_D2** to ensure the deployment takes less than 40 minutes. It is possible to deploy smaller VMs using this Template; however **all size possibilities have not been tested!**

This template requires the following parameters which are preconfigured:


| Name             | Description                     |
|:-----------------| :--------------------------------|
| LOCATION | Location name where the corresponding Azure artifacts will be created |
| ADDRESSPREFIX | Default Address Prefix for the entire Environment |
| DCSUBNETPREFIX | Address Prefix for Hosts in the same Subnet as the Domain Controller |
| CHEFSUBNETPREFIX | Address Prefix for Hosts in the same Subnet as the Chef Server |
| CONTOSOSYSCTRAPPTYPE | More on this later |
| CONTOSOSYSCTRAPPLOCATION | Physical Location where the Environment will be deployed |
| ADDCNAME | Name of the Domain Controller |
| CHEFSRVNAME | Name of the Chef Server |
| CHEFWINWKSNAME | Name of the Chef Windows Workstation |
| ADDCADMINUSERNAME | Admin Username of the Domain Controller |
| CHEFSRVADMINUSERNAME | Admin Username of the Chef Server |
| CHEFWINWKSADMINUSERNAME | Admin Username of the Chef Windows Workstation |
| ADDCADMINPASSWORD | Admin Password of the Domain Controller |
| CHEFSRVADMINPASSWORD | Admin Password of the Chef Server |
| CHEFWINWKSADMINPASSWORD | Admin Password of the Chef Windows Workstation |
| ADDCWINDOWSOSVERSION | Windows OS Version that the Domain Controller is running |
| UBUNTUOSVERSION | Ubuntu OS Version that the Chef Server is running |
| CHEFWINWKSWINDOWSOSVERSION | Windows OS Version that the Chef Windows Workstation is running |
| ADPUBIPDNSNAME | Publicly accessible FQDN associated with the Domain Controller |
| CHEFSRVPUBIPDNSNAME | Publicly accessible FQDN associated with the Chef Server |
| CHEFWINWKSPUBIPDNSNAME | Publicly accessible FQDN associated with the Chef Windows Workstation |
| ADDOMAINNAMEFQDN | FQDN of the Domain Controller |
| ADNICIPADDRESS | Static IP Address of the Domain Controller NIC Card |
| CHEFSRVNICIPADDRESS | Static IP Address of the Chef Server NIC Card |
| CHEFWINWKSNICIPADDRESS | Static IP Address of the Chef Windows Workstation NIC Card |
| ASSETLOCATION | Default Location of all Resources required to Deploy this Azure Template |
| UPDATEVNETDNSTEMPLATEFILE | Subnet to Update using the UpdateVnetDNS Resource in the Azure Template |


