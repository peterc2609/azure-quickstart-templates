log_level               :info
log_location            STDOUT
node_name               'chefadmin'
client_key              '/root/chef-repo/.chef/chefadmin.pem'
validation_client_name  'learn_chef_12_env-validator'
validation_key          '/root/chef-repo/.chef/learn_chef_12_env-validator.pem'
chef_server_url         'https://chefsrv.westeurope.cloudapp.azure.com/organizations/learn_chef_12_env'
syntax_check_cache_path '/root/chef-repo/.chef/syntax_check_cache'
cookbook_path           [ '/root/chef-repo/cookbooks']