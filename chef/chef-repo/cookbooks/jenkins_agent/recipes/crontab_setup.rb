apt_update 'update' do
  ignore_failure true
  action :update
end

directory "/var/#{node['jenkins_agent']['username']}" do
  owner node['jenkins_agent']['username']
  group node['jenkins_agent']['username']
  mode '0755'
  recursive true # Apply changes to all subdirectories and files
  action :create
end

cron 'chef-client' do
  minute  '*/2'
  hour    '*'
  day     '*'
  month   '*'
  weekday '*'
  user    'root'
  command '/usr/bin/chef-client -l info -L /var/log/chef-client.log'
  action  :create
  not_if "crontab -l | grep -q 'chef-client'"
end
