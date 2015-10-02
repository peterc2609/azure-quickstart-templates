#!/bin/bash
#
# install_chef-client.sh
#
# This Script is responsible for performing the following tasks on a Suse Server:
# - Install the Chef Client 12.4.3 (RPM)
# - Install the ChefDK 0.8.0 (RPM)
#
# Syntax:  ./install_chef-client.sh -u CHEF_USERNAME -p CHEF_PASSWORD -i SUSE_IP -r SUSE_REGION -h SUSE_HOSTNAME -c CHEF_HOSTNAME
# Example: ./install_chef-client.sh -u suseadmin -p P@ssw0rd! -i 10.0.1.44 -r westeurope -h susesrv001 -c chefsrv001
#
# The following scripts need to be parametrized and modified:
# - retrieve-chef-client-validator-cert.exp
# - retrieve-chefadmin-user-cert.exp
#
# Parse Script Parameters
while getopts ":u:p:i:r:h:c:" opt; do
  case "${opt}" in
        u) # Suse Admin Username
             CHEF_USERNAME=${OPTARG}
             ;;
        p) # Suse Admin Password
             CHEF_PASSWORD=${OPTARG}
             ;;
        i) # Suse Server IP Address
             SUSE_IP=${OPTARG}
             ;;
        r) # Suse Server Azure Region
             SUSE_REGION=${OPTARG}
             ;;
        h) # Suse Server Hostname
             SUSE_HOSTNAME=${OPTARG}
             ;;
        c) # Chef Server Hostname
             CHEF_HOSTNAME=${OPTARG}
             ;;			 
        \?) # Unrecognised option - show help
            echo -e \\n"Option [-${BOLD}$OPTARG${NORM}] is not allowed. All Valid Options are listed below:"
            echo -e "-u CHEF_USERNAME - Username of the Suse Server Administrator."
            echo -e "-p CHEF_PASSWORD - Password of the Suse Server Administrator."
            echo -e "-i SUSE_IP       - IP Address of the Suse Server."
            echo -e "-r SUSE_REGION   - Region where the Suse Server is being deployed in Azure."
            echo -e "-h SUSE_HOSTNAME - Hostname of the Suse Server."
			echo -e "-h CHEF_HOSTNAME - Hostname of the Suse Server."\\n
            echo -e "An Example of how to use this script is shown below:"
            echo -e "./install_chef-client.sh -u suseadmin -p P@ssw0rd1! -i 10.0.1.44 -r westeurope -h susesrv001"\\n
            exit 2
            ;;
  esac
done
shift $((OPTIND-1))

# Verifying the Script Parameters Values exist.
if [ -z "${CHEF_USERNAME}" ]; then
    echo "Suse Server Username must be provided."
    exit 2
fi

if [ -z "${CHEF_PASSWORD}" ]; then
    echo "Suse Server Password must be provided."
    exit 2
fi

if [ -z "${SUSE_IP}" ]; then
    echo "Suse Server IP Address must be provided."
    exit 2
fi

if [ -z "${SUSE_REGION}" ]; then
    echo "Suse Server Azure Region must be provided."
    exit 2
fi

if [ -z "${SUSE_HOSTNAME}" ]; then
    echo "Suse Server Hostname must be provided."
    exit 2
fi

if [ -z "${CHEF_HOSTNAME}" ]; then
    echo "Chef Server Hostname must be provided."
    exit 2
fi

# Updating the Chef Server Hosts File
sudo sed -i "2i$SUSE_IP $SUSE_HOSTNAME\\.$SUSE_REGION\\.cloudapp.azure.com $SUSE_HOSTNAME" /etc/hosts

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

# Retrieving the Chef Server Certificate
knife ssl fetch https://$CHEF_HOSTNAME\.$SUSE_REGION\.cloudapp.azure.com

# Copying the Chef Server SSL to '/etc/chef/trusted_certs'
cp /.chef/trusted_certs/* /etc/chef/trusted_certs/

# Copying client.rb file to '/etc/chef' directory
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/client.rb -P /etc/chef/

# Copying retrieve-chef-client-validator-cert.exp expect script from GitHub 
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/retrieve-chef-client-validator-cert.exp -P /Downloads

# Running expect script to retrieve Chef Client Validator Certificate from the Chef Server
cd /Downloads/
/usr/bin/expect retrieve-chef-client-validator-cert.exp

# Adding SLES Server to Chef Server
/usr/bin/chef-client

# Downloading and installing the Chef Development Kit
wget https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.8.0-1.el6.x86_64.rpm /Downloads

# Installing the Chef Development Kit
cd /Downloads/
sudo rpm -Uvh chefdk-0.8.0-1.el6.x86_64.rpm

# Generating a local chef-repo under the '/root' directory
cd /root
chef generate repo chef-repo

# Creating the '.chef' directory in the chef-repo
mkdir /root/chef-repo/.chef
cp /etc/chef/learn_chef_12_env-validator.pem /root/chef-repo/.chef/

# Copying knife.rb file to '/root/chef-repo/.chef' directory
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/knife.rb -P /root/chef-repo/.chef/

# Copying retrieve-chefadmin-user-cert.exp expect script from GitHub 
wget https://raw.githubusercontent.com/starkfell/azure-quickstart-templates/master/deploy_suse_and_chef/deploy_suse_and_chef/Scripts/retrieve-chefadmin-user-cert.exp -P /Downloads

# Running expect script to retrieve chefadmin user Certificate from the Chef Server
cd /Downloads/
/usr/bin/expect retrieve-chefadmin-user-cert.exp