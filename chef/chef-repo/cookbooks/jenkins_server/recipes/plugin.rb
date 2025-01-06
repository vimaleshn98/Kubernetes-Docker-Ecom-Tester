new_token = data_bag_item('jenkins_secrets', 'admin_token')['password']
bash 'set_JENKINS_USER_TOKEN' do
  code <<-EOH
    echo 'JENKINS_USER_ID=#{node['jenkins_server']['admin']}' >> /etc/environment
    echo 'JENKINS_API_TOKEN=#{new_token}' >> /etc/environment
  EOH
  notifies :run, 'execute[reload_shell_session]', :immediately
  not_if "grep 'JENKINS_API_TOKEN=#{new_token}' /etc/environment"
end

execute 'reload_shell_session' do
  command 'bash -c "source /etc/environment"'
  action :nothing
end

plugins = [
  'git', 'blueocean', 'docker-plugin', 'gitlab-plugin',
  'credentials', 'ssh-agent', 'workflow-aggregator',
  'kubernetes-cli', 'kubernetes', 'jfrog', 'copyartifact',
  'azure-credentials', 'azure-cli', 'docker-workflow',
  'docker-java-api', 'maven-plugin'
]

# Install all plugins using a single resource
plugins.each do |plugin|
  jenkins_plugin plugin do
    action :install
    # notifies :restart, 'service[jenkins]', :delayed
    only_if { node['jenkins_server']['reconfig'] == true }
  end
end