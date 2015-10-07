<# This Script does the following:
- Installs AD and DNS Management Tools.
- Disables IE ESC for Administrators.
- Adds DNS Record for the Chef Server.
- Sets WinRM Unencrypted Traffic to enabled.
- Enables IIS.
- Enables Directory Browsing on Default Web Site.
- Creates SQL Administrator Domain Account for the Install_SQL_Server_2014_SP1 Chef Cookbook.
- Creates 'C:\inetpub\wwwroot\chef' directory for the Chef Client.
- Creates 'C:\Chef\trusted_certs' directory for the Chef Client.
- File(s) are created in 'C:\Windows\Temp' stating whether the actions listed above were successful or not.
#>
param (
	[Parameter(Mandatory=$true, Position=0, HelpMessage="The Hostname of the Chef Server is required.")]
	[String]$ChefSrv,
	
	[Parameter(Mandatory=$true, Position=1, HelpMessage="The Domain Name, i.e. - contoso.corp, is required.")]
	[String]$ADDomain,

	[Parameter(Mandatory=$true, Position=2, HelpMessage="The IP Address of the Chef Server is required.")]
	[String]$ChefSrvIP,

	[Parameter(Mandatory=$true, Position=3, HelpMessage="The name of the SQL User to be created in Active Directory is required.")]
	[String]$SQLUsername,
	
	[Parameter(Mandatory=$true, Position=4, HelpMessage="The password of the SQL User to be created in Active Directory is required.")]
	[String]$SQLPassword
)	

# Installing Active Directory Management Tools
Install-WindowsFeature -Name RSAT-AD-Tools,RSAT-AD-PowerShell,RSAT-ADDS,RSAT-DNS-Server

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_AD_Tools_Install_Complete.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_AD_Tools_Install_Complete.txt").Close()
	}

# Disabling IE ESC for Administrators on Target Host. UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
$Disable_IE_ESC_Admins = New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name IsInstalled -Value 0 -Force

if ($Disable_IE_ESC_Admins.IsInstalled -eq 0)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IE_ESC_For_Admins_Disabled_Sucessfully.txt").Close()
	}
	
if ($Disable_IE_ESC_Admins.IsInstalled -ne 0)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IE_ESC_For_Admins_Disabled_Failed.txt").Close()
	}

# Adding DNS Record for Chef Server
Add-DnsServerResourceRecordA -Name $ChefSrv -ZoneName $ADDomain -AllowUpdateAny -IPv4Address $ChefSrvIP

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Chef_Server_DNS_Record_Added_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Chef_Server_DNS_Record_Addition_Failed.txt").Close()
	}

# Setting WinRM to allow Unencrypted traffic
$AllowUnencrypted = winrm set winrm/config/service '@{AllowUnencrypted="true"}'

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_WinRM_Allow_Unencrypted_Enabled_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_WinRM_Allow_Unencrypted_Enabled_Failed.txt").Close()
	}

# Enabling IIS
Install-WindowsFeature Web-Server,Web-Mgmt-Console

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IIS_Enabled_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IIS_Enabled_Failed.txt").Close()
	}

# Creating SQL Administrator Domain Account  for the Install_SQL_Server_2014_SP1 Chef Cookbook.
New-ADUser -Name $SQLUsername -AccountPassword (ConvertTo-SecureString -AsPlainText $SQLPassword -Force) -Path "CN=Users,DC=contoso,DC=corp" -PasswordNeverExpires $true -ChangePasswordAtLogon $false -Enabled $true

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_SQL_Admin_Domain_Account_Created_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_SQL_Admin_Domain_Account_Created_Failed.txt").Close()
	}

# Enabling Directory Browsing on Default Web Site
Set-WebConfigurationProperty -filter "/system.WebServer/directoryBrowse" -Name enabled -Value $true -PSPath "IIS:\Sites\Default Web Site"

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IIS_Directory_Browsing_Enabled_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IIS_Directory_Browsing_Enabled_Failed.txt").Close()
	}

# Creating 'C:\inetpub\wwwroot\chef' directory for the Chef Client
[System.IO.Directory]::CreateDirectory("C:\inetpub\wwwroot\chef")

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Create_IIS_chef_Directory_Sucess.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Create_IIS_chef_Directory_Failed.txt").Close()
	}	
	
# Creating 'C:\Chef\trusted_certs' directory for the Chef Client
[System.IO.Directory]::CreateDirectory("C:\chef\trusted_certs")

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Create_Chef_Client_Directories_Sucess.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Create_Chef_Client_Directories_Failed.txt").Close()
	}