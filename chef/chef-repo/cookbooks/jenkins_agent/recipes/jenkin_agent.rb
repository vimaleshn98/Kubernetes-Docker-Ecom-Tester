# new_token = data_bag_item('jenkins_secrets', 'admin_token')['password']
# bash 'set_JENKINS_USER_TOKEN' do
#   code <<-EOH
#     echo 'JENKINS_USER_ID=#{node['jenkins_server']['admin']}' >> /etc/environment
#     echo 'JENKINS_API_TOKEN=#{new_token}' >> /etc/environment
#   EOH
#   notifies :run, 'execute[reload_shell_session]', :immediately
#   not_if "grep 'JENKINS_API_TOKEN=#{new_token}' /etc/environment"
# end

# execute 'reload_shell_session' do
#   command 'bash -c "source /etc/environment"'
#   action :nothing
# end


# # Define Jenkins agent
# jenkins_ssh_slave 'executor' do
#   description 'Run test suites'
#   remote_fs   '/share/executor'
#   labels      ['executor', 'freebsd', 'jail']

#   # SSH specific attributes
#   host        node['jenkins_agent']['jenkins_server_ip'] # or 'slave.example.org'
#   user        node['jenkins_agent']['jenkins_server_user']
#   credentials node['jenkins_agent']['jenkins_server_user']
#   launch_timeout   30
#   ssh_retries      5
#   ssh_wait_retries 60
# end


