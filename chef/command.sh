knife cookbook upload 



# add berks file
# then
berks install

berks upload


knife cookbook upload jenkins_server

knife bootstrap 52.157.6.135 --ssh-user devops_vm_agent --ssh-identity-file devops_admin --node-name jenkins_agent --sudo -y
knife role from file jdk_setup.rb
knife role from file roles/pre_setup.rb
knife role from file roles/jenkins_agent.rb
knife role from file roles/docker_setup.rb


knife node run_list add jenkins_agent '''role[pre_setup]'''
knife node run_list add jenkins_agent '''role[jdk_setup]'''
# knife node run_list add jenkins_agent '''role[jenkins_agent]'''
knife node run_list add jenkins_agent '''role[docker_setup]'''


knife bootstrap 40.125.46.140 --ssh-user devops_vm_admin --ssh-identity-file devops_admin --node-name jenkins_server --sudo -y
knife role from file chef_server.rb
knife node run_list add jenkins_server '''role[chef_server]'''

knife role list
knife node list
knife node show jenkins_agent


knife data bag create jenkins_secrets admin_password
knife data bag from file jenkins_secrets admin_password.json
knife data bag from file jenkins_secrets jenkins_server_ssh.json



knife data bag show jenkins_secrets

knife node attribute set jenkins_server jenkins_server['reconfig'] false
['jenkins_server']['reconfig']
get token from ui

knife node show jenkins_server -F json > jenkins_server.json
knife node from file nodes/jenkins_server.json
