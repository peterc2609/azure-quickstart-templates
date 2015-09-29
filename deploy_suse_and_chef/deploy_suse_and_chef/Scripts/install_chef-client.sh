#!/bin/bash
# install_chef-client.sh
# Script is designed to run as 'root'
# USE THIS SCRIPT AT YOUR OWN RISK!

# Updating the Chef Server Hosts File
sudo sed -i "2i10.0.1.10 sles12srv.westeurope.cloudapp.azure.com SLES12SRV" /etc/hosts

# Printing out the correct FQDN of the Server
hostname -f

# Creating Directory to store binaries
mkdir /Downloads
cd /Downloads/

# Downloading the RPM Version of the installer
wget https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-12.4.3-1.el6.x86_64.rpm

# Installing the Chef-Client 12.4.3
sudo rpm -Uvh chef-12.4.3-1.el6.x86_64.rpm

# Creating the /etc/chef directories
mkdir -p /etc/chef/trusted_certs

#scp chefadmin@chefsrv.westeurope.cloudapp.azure.com:/home/chefadmin/learn_chef_12_env-validator.pem /etc/chef/learn_chef_12_env-validator.pem

# Retrieving the Chef Server Certificate
knife ssl fetch https://chefsrv.westeurope.cloudapp.azure.com

# Copying the Chef Server SSL to '/etc/chef/trusted_certs'
cp /.chef/trusted_certs/chefsrv_westeurope_cloudapp_azure_com.crt /etc/chef/trusted_certs/

# Copying client.rb file to '/etc/chef' directory
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/client.rb -P /etc/chef/

# Copying retrieve-chef-client-validator-cert.exp expect script from GitHub 
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/retrieve-chef-client-validator-cert.exp /Downloads

# Running expect script to retrieve Chef Client Validator Certificate from the Chef Server
cd /Downloads/ 
/usr/bin/expect retrieve-chef-client-validator-cert.exp

# Adding SLES Server to Chef Server
/usr/bin/chef-client

# Downloading and installing the Chef Development Kit
wget https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.8.0-1.el6.x86_64.rpm /Downloads

cd /Downloads/
sudo rpm -Uvh chefdk-0.8.0-1.el6.x86_64.rpm

cd /root
chef generate repo chef-repo

mkdir .chef
cp /etc/chef/learn_chef_12_env-validator.pem /root/chef-repo/.chef/

# Copying knife.rb file to '/root/chef-repo/.chef' directory
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/knife.rb /root/chef-repo/.chef/

# Copying retrieve-chefadmin-user-cert.exp expect script from GitHub 
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/retrieve-chefadmin-user-cert.exp /Downloads

# Running expect script to retrieve chefadmin user Certificate from the Chef Server
cd /Downloads/ 
/usr/bin/expect retrieve-chefadmin-user-cert.exp


