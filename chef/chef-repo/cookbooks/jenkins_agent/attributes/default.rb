# This is a Chef Infra attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# Set a default name
default['starter_name'] = 'Sam Doe'
default['jenkins_agent']['jdk_version'] = '17'
default['jenkins_agent']['username'] = 'devops_vm_agent'
default['jenkins_agent']['bashrc_file'] = "/home/#{node['jenkins_agent']['username']}/.bashrc"


default['jenkins_agent']['jenkins_server_ip'] = '172.191.1.38'
default['jenkins_agent']['jenkins_server_user'] = 'devops_vm_admin'
default['jenkins_agent']['agent_name'] = 'agent1'

default['jenkins_server']['credentail_id'] = 'admin'
default['jenkins_server']['admin'] = 'admin'

default['docker']['run_test_container'] == false
default['docker']['open_2376_port'] == true

default['jenkins_agent']['docker_exec_start']="/usr/bin/dockerd --containerd=/run/containerd/containerd.sock"
# For further information, see the Chef documentation (https://docs.chef.io/attributes).
