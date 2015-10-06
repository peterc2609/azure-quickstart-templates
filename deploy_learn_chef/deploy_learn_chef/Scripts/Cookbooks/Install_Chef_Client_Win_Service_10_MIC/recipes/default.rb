#
# Cookbook Name:: Install_Chef-Client_Windows_Service_10_MIC
# Recipe:: default
#
# Copyright (c) 2015 Ryan Irujo, All Rights Reserved.

# Installing the Chef-Client Windows Service.
powershell_script 'Install Chef-Client Windows Service' do
  code 'chef-service-manager -a install'
  guard_interpreter :powershell_script
  not_if '($Chef_Client_Service = (gwmi -class Win32_Service | Where-Object {$_.Name -eq "chef-client"}).Name -eq "chef-client")'
end

# Configuring the Chef-Client Windows Service to Automatic (Delayed Start) and the Check-In Interval to 10 Minutes.
powershell_script 'Set Chef-Client Windows Service Check-In Interval: 10 Minutes' do
  code '$Set_Service = & cmd /c sc config chef-client start=delayed-auto binPath=""C:\opscode\chef\embedded\bin\ruby" "C:\opscode\chef\bin\chef-windows-service" -c C:\chef\client.rb -i 600 -L C:\chef\client.log"'
  guard_interpreter :powershell_script
  not_if '$Check_Service = & cmd /c sc qc chef-client ; $Check_Service[6] -match 600'
end

# Enabling and Starting the Chef-Client Service.
service 'chef-client' do
  action [:enable, :start]
end