# Define Jenkins agent
jenkins_ssh_slave 'executor' do
  description 'Run test suites'
  remote_fs   node['jenkins_ssh_slave']['remote_fs']
  labels      ['executor', 'freebsd', 'jail']

  # SSH specific attributes
  host        node['jenkins_agent']['jenkins_agent_ip'] # or 'slave.example.org'
  user        node['jenkins_agent']['jenkins_agent_user']
  credentials node['jenkins_agent']['jenkins_agent_user']
  launch_timeout   30
  ssh_retries      5
  ssh_wait_retries 60
end