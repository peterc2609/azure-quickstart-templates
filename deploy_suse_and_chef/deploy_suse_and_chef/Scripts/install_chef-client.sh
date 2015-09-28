#!/bin/bash
# install_chef-client.sh
# Script is designed to run as 'root'
# USE THIS SCRIPT AT YOUR OWN RISK!

# Creating Directory to store binaries
mkdir /Downloads
cd /Downloads/

# Downloading the RPM Version of the installer
wget https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-12.4.3-1.el6.x86_64.rpm

# Installing the Chef-Client 12.4.3
sudo rpm -Uvh chef-12.4.3-1.el6.x86_64.rpm

# Creating the /etc/chef directories
mkdir /etc/chef/trusted_certs

#scp chefadmin@chefsrv.westeurope.cloudapp.azure.com:/home/chefadmin/learn_chef_12_env.pem /etc/chef/learn_chef_12_env.pem

# Retrieving the Chef Server Certificate
knife ssl fetch https://chefsrv.westeurope.cloudapp.azure.com

# Copying the Chef Server SSL to '/etc/chef/trusted_certs'
cp /root/.chef/trusted_certs/CHEFSRV_contoso_corp.crt /etc/chef/trusted_certs/



