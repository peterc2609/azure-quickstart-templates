log_level                :info 
log_location             STDOUT 
node_name                'chefadmin' 
client_key               'C:/Chef/.chef/chefadmin.pem' 
validation_client_name   'learn_chef_12_env-validator' 
validation_key           'C:/Chef/.chef/learn_chef_12_env-validator.pem' 
chef_server_url          'https://chefsrv.contoso.corp/organizations/learn_chef_12_env' 
syntax_check_cache_path  'C:/Chef/.chef/syntax_check_cache' 
cookbook_path [ 'C:/Chef/chef-repo/cookbooks' ] 
knife[:editor] = '"C:\Program Files (x86)\Notepad++\notepad++.exe" -nosession -multiInst'