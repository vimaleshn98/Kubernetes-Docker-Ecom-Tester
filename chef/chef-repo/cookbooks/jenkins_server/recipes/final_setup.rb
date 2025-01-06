service 'jenkins' do
  action :restart  # Only restart when notified
  ignore_failure true
  only_if { node['jenkins_server']['reconfig'] == true }
end

Chef::Log.info("before: #{node['jenkins_server']['reconfig']}")
ruby_block 'set_reconfig_false' do
  block do
    node.default['jenkins_server']['reconfig'] = false
  end
  only_if { node['jenkins_server']['reconfig'] == true }
end

Chef::Log.info("After: #{node['jenkins_server']['reconfig']}")