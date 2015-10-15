# Learn Chef Deployment

| Deploy to Azure  | Author                          | Template Name   |
|:-----------------|:--------------------------------| :---------------| :---------------|
| <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstarkfell%2Fazure-quickstart-templates%2Fmaster%2Flearn_chef%2Fazuredeploy.json" target="_blank"><img src="http://azuredeploy.net/deploybutton_small.png"/></a> | [starkfell](https://github.com/starkfell) | Learn Chef (https://github.com/starkfell/azure-quickstart-templates/tree/master/learn_chef)

This template provisions an environment in Azure for learning Chef.
 
 The following VMs are deployed with their own publicly accessible FQDN's for RDP and SSH Access respectively.
 - Ubuntu Server 14.04 running Chef Server 12
   - Chef Server 12.1 installed
   - Chef Management Console
   - Chef Reporting
   - First Chef Admin User created
   - First Chef Organization created
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
| VNETNAME | Name of the Virtual Network where all of the Resources are being deployed |
| DCSUBNETNAME | DC Subnet Name |
| CHEFSUBNETNAME | Chef Subnet Name |
| ADDRESSPREFIX | Default Address Prefix for the entire Environment |
| DCSUBNETPREFIX | Address Prefix for Hosts in the same Subnet as the Domain Controller |
| CHEFSUBNETPREFIX | Address Prefix for Hosts in the same Subnet as the Chef Server |
| CONTOSOCHEFSTORAGENAME | Name of the Storage Account where the Resources are being deployed |
| CONTOSOCHEFSTORAGEPTYPE | The Type of Storage used for the Resources being deployed |
| ADDCNAME | The Name of the Active Directory Server |
| CHEFSRVNAME | The Name of the Ubuntu Server running Chef Server 12 |
| CHEFWINWKSNAME | The Name of the Chef Windows Workstation |
| CHEFWINSANDNAME | The Name of the Chef Windows Sandbox |
| ADDCADMINUSERNAME | The name of the Windows Server account with local admin rights and admin rights in Active Directory |
| CHEFSRVADMINUSERNAME | The name of the Ubuntu Server account with sudo rights |
| CHEFWINWKSADMINUSERNAME | The name of the Windows Server account with local admin rights |
| CHEFWINSANDADMINUSERNAME | The name of the Windows Server account with local admin rights |
| SQLADMINUSERNAME | The usename of the SQL Domain account being created for use later after deployment |
| ADDCADMINPASSWORD | The password of the Windows Server account with local admin rights and admin rights in Actve Directory |
| CHEFSRVADMINPASSWORD | The password of the Ubuntu Server account with sudo rights |
| CHEFWINWKSADMINPASSWORD | The password of the Windows Server account with local admin rights |
| CHEFWINSANDADMINPASSWORD | The password of the Windows Server account with local admin rights |
| SQLADMINPASSWORD | The password of the SQL Domain account being created for use later after deployment |
| ADDCIMAGEPUBLISHER | The Microsoft Image Publisher of the Image being used for the Active Directory Domain Controller VM |
| ADDCIMAGEOFFER | The Microsoft Image Offer of the Image being used for the Active Directory Domain Controller VM |
| ADDCIMAGESKU | The Microsoft Image SKU of the Image being used for the Active Directory Domain Controller VM |
| ADDCIMAGEVERSION | The Version Number of the fully patched Windows Image being deployed |
| CHEFSRVIMAGEPUBLISHER | The Vendor Image Publisher of the Image being used for the Ubuntu Server VM |
| CHEFSRVIMAGEOFFER | The Vendor Image Offer of the Image being used for the Ubuntu Server VM |
| CHEFSRVIMAGESKU | The Vendor Image SKU of the Image being used for the Ubuntu Server VM |
| CHEFSRVIMAGEVERSION | Ubuntu OS Version that the Chef Server is running |
| CHEFWINWKSIMAGEPUBLISHER | The Version Number of the fully patched Ubuntu Image being deployed |
| CHEFWINWKSIMAGEOFFER | The Microsoft Image Publisher of the Image being used for the Chef Windows Workstation VM |
| CHEFWINWKSIMAGESKU | The Microsoft Image SKU of the Image being used for the Chef Windows Workstation VM |
| CHEFWINWKSIMAGEVERSION | The Version Number of the fully patched Windows Image being deployed |
| CHEFWINSANDIMAGEPUBLISHER | The Microsoft Image Publisher of the Image being used for the Chef Windows Sandbox VM |
| CHEFWINSANDIMAGEOFFER | The Microsoft Image Offer of the Image being used for the Chef Windows Sandbox VM |
| CHEFWINSANDIMAGESKU | The Microsoft Image SKU of the Image being used for the Chef Windows Sandbox VM |
| CHEFWINSANDIMAGEVERSION | The Version Number of the fully patched Windows Image being deployed |
| ADDCOSDISKNAME | The Name of the Active Directory Domain Controller OS Disk |
| CHEFSRVOSDISKNAME | The Name of the Ubuntu Server OS Disk |
| CHEFWINWKSOSDISKNAME | The Name of the Chef Windows Workstation OS Disk |
| CHEFWINSANDOSDISKNAME | The Name of the Chef Windows Sandbox OS Disk |
| ADDCDATADISKNAME | The Name of the Active Directory Domain Controller Data Disk |
| ADDCDATADISKSIZE | The Size of the Active Directory Domain Controller Data Disk in GB |
| CHEFWINWKSDATADISKNAME | The Name of the Chef Windows Workstation Data Disk |
| CHEFWINWKSDATADISKSIZE | The Size of the Chef Windows Workstation Data Disk in GB |
| CHEFWINSANDDATADISKNAME | The Name of the Chef Windows Sandbox Data Disk |
| CHEFWINSANDDATADISKSIZE | The Size of the Chef Windows Sandbox Data Disk in GB |
| ADDCVMSIZE | The Size of the Active Directory Domain Controller Server VM being deployed in Azure |
| CHEFSRVVMSIZE | The Size of the Ubuntu Server VM being deployed in Azure |
| CHEFWINWKSVMSIZE | The Size of the Chef Windows Workstation VM being deployed in Azure |
| CHEFWINSANDVMSIZE | The Size of the Chef Windows Sandbox VM being deployed in Azure |
| ADPUBIPDNSNAME | This is the FQDN for RDP Access into the AD VM |
| CHEFSRVPUBIPDNSNAME | The is the FQDN for SSH Access into the Chef Server |
| CHEFWINWKSPUBIPDNSNAME | This is the FQDN for RDP Access into the Chef Windows Workstation VM |
| CHEFWINSANDPUBIPDNSNAME | This is the FQDN for RDP Access into the Chef Windows Sandbox VM |
| ADDOMAINNAMEFQDN | The FQDN of the AD Domain created |
| ADNICIPADDRESS | The IP address of the new AD VM |
| CHEFSRVNICIPADDRESS | The IP address of the new Chef Server VM |
| CHEFWINWKSNICIPADDRESS | The IP address of the new Chef Windows Workstation VM |
| CHEFWINSANDNICIPADDRESS | The IP address of the new Chef Windows Sandbox VM |
| CHEFORGANIZATION | The Name of the Chef Organization being created |
| INSTALLCHEFSERVERSCRIPTURI | The location of the custom Chef Server Installation Script for the Ubuntu Server VM |
| INSTALLCHEFSERVERSCRIPTNAME | The Name of the Chef Server Installation Script |
| INSTALLADTOOLSSCRIPTURI | The location of the custom Active Directory Tools Installation Script for the Active Directory Domain Controller VM |
| INSTALLADTOOLSSCRIPTNAME | The Name of the Active Directory Tools Custom Script |
| CHEFWINWKSCUSTOMCONFIGSSCRIPTURI | The location of the custom Configuration Script for the Chef Windows Workstation VM |
| CHEFWINWKSCUSTOMCONFIGSSCRIPTNAME | The Name of the Chef Windows Workstation Custom Script |
| CHEFWINSANDCUSTOMCONFIGSSCRIPTURI | The location of the custom Configuration Script for the Chef Windows Sandbox VM |
| CHEFWINSANDCUSTOMCONFIGSSCRIPTNAME | The Name of the Chef Windows Sandbox Custom Script |
| VNETDNSTEMPLATEURI | The location of resources such as templates and DSC modules that the script is dependent |
| ASSETLOCATION | Default Location of all Resources required to Deploy this Azure Template |
