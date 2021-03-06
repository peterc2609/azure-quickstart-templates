#!/bin/bash
#
# install_chef_server.sh
#
# This Script is responsible for configuring an Ubuntu Server's Host File with an assigned IP Address and FQDN and then installs:
# - Chef Server 12
# - Chef Management Console
# - Chef Reporting
# - Creates the first Chef Admin User
# - Creates the first Chef Organization on the Chef Server
#
#
# Syntax:  ./install_chef_server.sh -u CHEF_USERNAME -p CHEF_PASSWORD -i CHEF_IP -r AZURE_REGION -h CHEF_HOSTNAME -o CHEF_ORG
# Example: ./install_chef_server.sh -u chefadmin -p P@ssw0rd! -i 10.0.1.44 -r westeurope -h chefsrv001 -o learn_chef_12_env

# Parse Script Parameters
while getopts ":u:p:i:r:h:o:" opt; do
  case "${opt}" in
        u) # Chef Admin Username
             CHEF_USERNAME=${OPTARG}
             ;;
        p) # Chef Admin Password
             CHEF_PASSWORD=${OPTARG}
             ;;
        i) # Chef Server IP Address
             CHEF_IP=${OPTARG}
             ;;
        r) # Chef Server Azure Region
             AZURE_REGION=${OPTARG}
             ;;
        h) # Chef Server Hostname
             CHEF_HOSTNAME=${OPTARG}
             ;;
        o) # Chef Organization Name
             CHEF_ORG=${OPTARG}
             ;;				 
        \?) # Unrecognised option - show help
            echo -e \\n"Option [-${BOLD}$OPTARG${NORM}] is not allowed. All Valid Options are listed below:"
            echo -e "-u CHEF_USERNAME - Username of the Chef Server Administrator."
            echo -e "-p CHEF_PASSWORD - Password of the Chef Server Administrator."
            echo -e "-i CHEF_IP       - IP Address of the Chef Server."
            echo -e "-r AZURE_REGION   - Region where the Chef Server is being deployed in Azure."
            echo -e "-h CHEF_HOSTNAME - Hostname of the Chef Server."
			echo -e "-o CHEF_ORG      - Chef Organization Name."\\n			
            echo -e "An Example of how to use this script is shown below:"
            echo -e "./install_chef_server.sh -u chefadmin -p P@ssw0rd1! -i 10.0.1.44 -r westeurope -h chefsrv001 -o learn_chef_12_env"\\n
            exit 2
            ;;
  esac
done
shift $((OPTIND-1))

# Verifying the Script Parameters Values exist.
if [ -z "${CHEF_USERNAME}" ]; then
    echo "Chef Server Username must be provided."
    exit 2
fi

if [ -z "${CHEF_PASSWORD}" ]; then
    echo "Chef Server Password must be provided."
    exit 2
fi

if [ -z "${CHEF_IP}" ]; then
    echo "Chef Server IP Address must be provided."
    exit 2
fi

if [ -z "${AZURE_REGION}" ]; then
    echo "Chef Server Azure Region must be provided."
    exit 2
fi

if [ -z "${CHEF_HOSTNAME}" ]; then
    echo "Chef Server Hostname must be provided."
    exit 2
fi

if [ -z "${CHEF_ORG}" ]; then
    echo "Chef Organization Name must be provided."
    exit 2
fi

# Updating the Chef Server Hosts File
sed -i "2i$CHEF_IP $CHEF_HOSTNAME\\.$AZURE_REGION\\.cloudapp.azure.com $CHEF_HOSTNAME" /etc/hosts

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
sudo cp /var/opt/opscode/nginx/ca/$CHEF_HOSTNAME\.$AZURE_REGION\.cloudapp.azure.com.crt /home/$CHEF_USERNAME/

# Creating First User on the Chef Server
sudo chef-server-ctl user-create $CHEF_USERNAME Chef Admin $CHEF_USERNAME@devops.io $CHEF_PASSWORD --filename /home/$CHEF_USERNAME/$CHEF_USERNAME.pem

# Creating the First Organization on the Chef Server
sudo chef-server-ctl org-create $CHEF_ORG Learn Chef 12 Environment --association_user $CHEF_USERNAME --filename /home/$CHEF_USERNAME/$CHEF_ORG-validator.pem

echo "Chef Server 12 Installation is Complete!"