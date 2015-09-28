#!/bin/bash

# Input Argument Variables
CHEF_USERNAME="chefadmin"
CHEF_PASSWORD="LearnChef!"


# Parse Script Parameters
while getopts ":u:p:v:h" optname; do
  log "Option $optname set with value ${OPTARG}"

  case "$optname" in
        u) # Admin user name
                CHEF_USERNAME=${OPTARG}
                ;;
        p) # Admin user name
                CHEf_PASSWORD=${OPTARG}
                ;;
        h)  # Helpful hints
                help
                exit 2
                ;;
        \?) # Unrecognised option - show help
                echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed."
                help
                exit 2
                ;;
  esac
done

# Updating the Chef Server Hosts File
sudo sed -i "2i10.0.1.4 chefsrv.westeurope.cloudapp.azure.com CHEFSRV" /etc/hosts

# Printing out the correct FQDN of the Server
hostname -f

# Retrieving the Chef Server 12 Binaries
sudo wget https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/trusty/chef-server-core_12.1.0-1_amd64.deb

# Installing Chef Server 12
sudo dpkg -i chef-server-core_12.1.0-1_amd64.deb

# Running the Chef Server Initial Configuration
sudo chef-server-ctl reconfigure
sleep 15s

# Installing the the Chef Management Web UI
sudo chef-server-ctl install opscode-manage

# Running the Web UI Initial Configuration and then Running the Chef Server Configuration
sudo chef-server-ctl reconfigure
sleep 15s
sudo opscode-manage-ctl reconfigure
sleep 15s

# Installing the Chef Push Jobs Feature
sudo chef-server-ctl install opscode-push-jobs-server

# Running the Chef Server Configuration
sudo chef-server-ctl reconfigure
sleep 15s
# Installing the Chef Server Reporting Feature
sudo chef-server-ctl install opscode-reporting

# Running the Reporting Initial Configuration and then Running the Chef Server Configuration
sudo chef-server-ctl reconfigure
sleep 15s
sudo opscode-reporting-ctl reconfigure
sleep 15s

# Copying the Chef Server Certificate to the chefadmin home directory for further use
sudo cp /var/opt/opscode/nginx/ca/chefsrv.westeurope.cloudapp.azure.com.crt /home/chefadmin/

# Creating First User on the Chef Server
sudo chef-server-ctl user-create $CHEF_USERNAME Chef Admin chefadmin@devops.io $CHEF_PASSWORD --filename /home/chefadmin/chefadmin.pem

# Creating the First Organization on the Chef Server
sudo chef-server-ctl org-create learn_chef_12_env Learn Chef 12 Environment --association_user $CHEF_USERNAME --filename /home/chefadmin/learn_chef_12_env-validator.pem

echo "Chef Server 12 Installation is Complete!"