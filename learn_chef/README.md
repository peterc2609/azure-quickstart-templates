# Learn Chef Deployment

| Deploy to Azure  | Author                          | Template Name   |
|:-----------------|:--------------------------------| :---------------| :---------------|
| <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstarkfell%2Fazure-quickstart-templates%2Fmaster%2Flearn_chef%2Fazuredeploy.json" target="_blank"><img src="http://azuredeploy.net/deploybutton_small.png"/></a> | [starkfell](https://github.com/starkfell) | Learn Chef (https://github.com/starkfell/azure-quickstart-templates/tree/master/learn_chef)

This template provisions an environment in Azure for learning Chef.
 
 The following VMs are deployed with their own publicly accessible FQDN's for RDP and SSH Access respectively.
 - Ubuntu Server 14.04 running Chef Server 12
 - Windows Server 2012 R2 running as a Domain Controller
   - Active Directory Tools installed
   - IIS Installed with Directory Browsing enabled
   - DNS Record added for Chef Server
   - SQL Admin Domain Account created and enabled
   - WinRM Configured for Chef
   - Additional Custom Folders created
 - Windows Server 2012 R2 configured as a Chef Windows Workstation
   - Domain Joined
   - Active Directory Tools installed
   - Chef DK 0.8.1 installed
   - Notepad++ 6.8.1 installed
   - GitHub Desktop downloaded
   - knife.rb file downloaded and configured
   - WinRM Configured for Chef
   - Additional Custom Folders created
 - Windows Server 2012 R2 non-domain-joined for use as a Sandbox
   - Domain Joined
   - Notepad++ 6.8.1 installed
   - .NET Framework 3.5 enabled
   - WinRM Configured for Chef
   - Additional Custom Folders created
   
All of the VMs deployed in this template are **Standard_D1**. It is possible to deploy smaller VMs using this Template; however **all size possibilities have not been tested!**

The following Parameter Values must be unique to the Region you are deploying this Template to! If the values you set here already exist in your region, the Template deployment will fail!
 - CONTOSOCHEFSTORAGENAME
 - ADPUBIPDNSNAME
 - CHEFSRVPUBIPDNSNAME
 - CHEFWINWKSPUBIPDNSNAME
 - CHEFWINSANDPUBIPDNSNAME

 
This template requires the following parameters which are preconfigured:


| Name             | Description                     |
|:-----------------| :--------------------------------|
| LOCATION | Location name where the corresponding Azure artifacts will be created |
| VNETNAME | |
| DCSUBNETNAME | |
| CHEFSUBNETNAME | |
| ADDRESSPREFIX | Default Address Prefix for the entire Environment |
| DCSUBNETPREFIX | Address Prefix for Hosts in the same Subnet as the Domain Controller |
| CHEFSUBNETPREFIX | Address Prefix for Hosts in the same Subnet as the Chef Server |
| CONTOSOCHEFSTORAGENAME |  |
| CONTOSOCHEFSTORAGEPTYPE | More on this later |
| ADDCNAME | Name of the Domain Controller |
| CHEFSRVNAME | Name of the Chef Server |
| CHEFWINWKSNAME | Name of the Chef Windows Workstation |
| CHEFWINSANDNAME | |
| ADDCADMINUSERNAME | Admin Username of the Domain Controller |
| CHEFSRVADMINUSERNAME | Admin Username of the Chef Server |
| CHEFWINWKSADMINUSERNAME | Admin Username of the Chef Windows Workstation |
| CHEFWINSANDADMINUSERNAME | |
| SQLADMINUSERNAME | |
| ADDCADMINPASSWORD | Admin Password of the Domain Controller |
| CHEFSRVADMINPASSWORD | Admin Password of the Chef Server |
| CHEFWINWKSADMINPASSWORD | Admin Password of the Chef Windows Workstation |
| CHEFWINSANDADMINPASSWORD | |
| SQLADMINPASSWORD | |
| ADDCIMAGEPUBLISHER | |
| ADDCIMAGEOFFER | |
| ADDCIMAGESKU | |
| ADDCIMAGEVERSION | Windows OS Version that the Domain Controller is running |
| CHEFSRVIMAGEPUBLISHER | |
| CHEFSRVIMAGEOFFER | |
| CHEFSRVIMAGESKU | |
| CHEFSRVIMAGEVERSION | Ubuntu OS Version that the Chef Server is running |
| CHEFWINWKSIMAGEPUBLISHER | |
| CHEFWINWKSIMAGEOFFER | |
| CHEFWINWKSIMAGESKU | |
| CHEFWINWKSIMAGEVERSION | Windows OS Version that the Chef Windows Workstation is running |
| CHEFWINSANDIMAGEPUBLISHER | |
| CHEFWINSANDIMAGEOFFER | |
| CHEFWINSANDIMAGESKU | |
| CHEFWINSANDIMAGEVERSION | Windows OS Version that the Chef Windows Workstation is running |
| ADDCOSDISKNAME | |
| CHEFSRVOSDISKNAME | |
| CHEFWINWKSOSDISKNAME | |
| CHEFWINSANDOSDISKNAME | |
| CHEFWINWKSDATADISKNAME | |
| CHEFWINWKSDATADISKSIZE | |
| CHEFWINSANDDATADISKNAME | |
| CHEFWINSANDDATADISKSIZE | |
| ADDCVMSIZE | |
| CHEFSRVVMSIZE | |
| CHEFWINWKSVMSIZE | |
| CHEFWINSANDVMSIZE | |
| ADPUBIPDNSNAME | Publicly accessible FQDN associated with the Domain Controller |
| CHEFSRVPUBIPDNSNAME | Publicly accessible FQDN associated with the Chef Server |
| CHEFWINWKSPUBIPDNSNAME | Publicly accessible FQDN associated with the Chef Windows Workstation |
| CHEFWINSANDPUBIPDNSNAME |
| ADDOMAINNAMEFQDN | FQDN of the Domain Controller |
| ADNICIPADDRESS | Static IP Address of the Domain Controller NIC Card |
| CHEFSRVNICIPADDRESS | Static IP Address of the Chef Server NIC Card |
| CHEFWINWKSNICIPADDRESS | Static IP Address of the Chef Windows Workstation NIC Card |
| CHEFWINSANDNICIPADDRESS | |
| CHEFORGANIZATION | |
| INSTALLCHEFSERVERSCRIPTURI | |
| INSTALLCHEFSERVERSCRIPTNAME | |
| INSTALLADTOOLSSCRIPTURI | |
| INSTALLADTOOLSSCRIPTNAME | |
| CHEFWINWKSCUSTOMCONFIGSSCRIPTURI | |
| CHEFWINWKSCUSTOMCONFIGSSCRIPTNAME | |
| CHEFWINSANDCUSTOMCONFIGSSCRIPTURI | |
| CHEFWINSANDCUSTOMCONFIGSSCRIPTNAME | |
| VNETDNSTEMPLATEURI | |
| ASSETLOCATION | Default Location of all Resources required to Deploy this Azure Template |

