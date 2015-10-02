#!/bin/bash
#
# install_chef_server.sh
#
# This Script is responsible for configuring an Ubuntu Server's Host File with an assigned IP Address and FQDN and then installs:
# - Chef Server 12
# - Chef Management Console
# - Chef Reporting
# - Creates the first Chef Admin User
# - Creates the first Chef Organization on the Server
#
#
# Syntax: ./install_chef_server.sh -u CHEF_USERNAME -p CHEF_PASSWORD
#
# Parse Script Parameters
while getopts ":u:p:" opt; do
  case "${opt}" in
        u) # Chef Admin Username
             CHEF_USERNAME=${OPTARG}
             ;;
        p) # Chef Admin Password
             CHEF_PASSWORD=${OPTARG}
             ;;
        \?) # Unrecognised option - show help
              echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed. -u CHEF_USERNAME and -p CHEF_PASSWORD are the only options available."
                exit 2
                ;;
  esac
done
shift $((OPTIND-1))

# Verifying the Script Parameters Values exist.
if [ -z "${CHEF_USERNAME}" ]; then
    echo "Chef Username must be set."
    exit 2
fi

if [ -z "${CHEF_PASSWORD}" ]; then
    echo "Chef Password must be set."
    exit 2
fi

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