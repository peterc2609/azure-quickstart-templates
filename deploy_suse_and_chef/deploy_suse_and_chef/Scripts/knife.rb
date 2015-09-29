log_level               :info
log_location            STDOUT
node_name               'chefadmin'
client_key              '~/chef-repo/.chef/chefadmin.pem'
validation_client_name  'learn_chef_12_env-validator'
validation_key          '~/chef-repo/.chef/learn_chef_12_env-validator.pem'
chef_server_url         'https://chefsrv.westeurope.cloudapp.azure.com/organizations/learn_chef_12_env'
syntax_check_cache_path '~/chef-repo/.chef/syntax_check_cache'
cookbook_path           [ '~/chef-repo/cookbooks']