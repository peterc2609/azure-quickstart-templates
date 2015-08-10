#!/bin/bash

# Input Argument Variables
CHEF_USERNAME="chefadmin"
CHEF_PASSOWRD="LearnChef!"


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


# Retrieving the Chef Server 12 Binaries
wget https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/trusty/chef-server-core_12.1.0-1_amd64.deb

# Installing Chef Server 12
dpkg -i chef-server-core_12.1.0-1_amd64.deb

# Running the Chef Server Initial Configuration
chef-server-ctl reconfigure

# Creating First User on the Chef Server
chef-server-ctl user-create $CHEF_USERNAME Chef Admin chefadmin@devops.io $CHEF_PASSWORD --filename /home/chefadmin/chefadmin.pem

# Creating the First Organization on the Chef Server
chef-server-ctl org-create learn_chef_12_env Learn Chef 12 Environment --association_user $CHEF_USERNAME --filename /home/chefadmin/learn_chef_12_env.pem

# Installing the the Chef Management Web UI
chef-server-ctl install opscode-manage

# Running the Web UI Initial Configuration and then Running the Chef Server Configuration
opscode-manage-ctl reconfigure ; chef-server-ctl reconfigure

# Installing the Chef Push Jobs Feature
chef-server-ctl install opscode-push-jobs-server

# Running the Chef Server Configuration
chef-server-ctl reconfigure

# Installing the Chef Server Reporting Feature
chef-server-ctl install opscode-reporting

# Running the Reporting Initial Configuration and then Running the Chef Server Configuration
opscode-reporting-ctl reconfigure ; chef-server-ctl reconfigure

echo "Chef Server 12 Installation from Custom Script is Complete!"