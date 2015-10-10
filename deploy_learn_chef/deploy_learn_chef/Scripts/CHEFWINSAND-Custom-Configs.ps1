<# This Script does the following:
- Disables IE ESC for Administrators.
- Sets WinRM Unencrypted Traffic to enabled and Authentication to Basic.
- Enables .NET Framework 3.5 for SQL Install.
- Creates 'C:\Chef\trusted_certs' directory for the Chef Client.
- Downloads and Installs Notepad++.
- File(s) are created in 'C:\Windows\Temp' stating whether the actions listed above were successful or not.
#>

# Disabling IE ESC for Administrators on Target Host. UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}".
$Disable_IE_ESC_Admins = New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name IsInstalled -Value 0 -Force

if ($Disable_IE_ESC_Admins.IsInstalled -eq 0)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IE_ESC_For_Admins_Disabled_Sucessfully.txt").Close()
	}
	
if ($Disable_IE_ESC_Admins.IsInstalled -ne 0)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_IE_ESC_For_Admins_Disablement_Failed.txt").Close()
	}

# Setting WinRM to allow Unencrypted traffic and setting Authentication to Basic.
$AllowUnencrypted = winrm set winrm/config/service '@{AllowUnencrypted="true"}'

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_WinRM_Allow_Unencrypted_Enabled_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_WinRM_Allow_Unencrypted_Enablement_Failed.txt").Close()
	}

$AllowBasicAuth = winrm set winrm/config/service/auth '@{Basic="true"}'

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_WinRM_Allow_Basic_Auth_Enabled_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_WinRM_Allow_Basic_Auth_Enablement_Failed.txt").Close()
	}
	
#Enabling .NET Framework 3.5 for SQL Install.
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_dotNET_Framework_35_Enabled_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_dotNET_Framework_35_Enablement_Failed.txt").Close()
	}
	
# Creating 'C:\Chef\trusted_certs' directory for the Chef Client.
[System.IO.Directory]::CreateDirectory("C:\chef\trusted_certs")

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Chef_Client_Directories_Created_Sucessfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_Chef_Client_Directories_Creation_Failed.txt").Close()
	}

# Download Notepad++.
$Notepad_WebClient = New-Object System.Net.WebClient
$Notepad_URI       = "https://notepad-plus-plus.org/repository/6.x/6.8.1/npp.6.8.1.Installer.exe"
$Notepad_File      = "C:\Windows\Temp\npp.6.8.1.Installer.exe"
$Notepad_WebClient.DownloadFile($Notepad_URI,$Notepad_File)

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_NotepadPlusPlus_Downloaded_Successfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_NotepadPlusPlus_Download_Failed.txt").Close()
	}

# Install Notepad++.
C:\Windows\Temp\npp.6.8.1.Installer.exe /S

If ($?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_NotepadPlusPlus_Installed_Successfully.txt").Close()
	}
If (!$?)
	{
		[System.IO.File]::Create("C:\Windows\Temp\_NotepadPlusPlus_Install_Failed.txt").Close()
	}