# This is a Chef Infra attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# Set a default name
default['starter_name'] = 'Sam Doe'
default['jenkins_server']['admin'] = 'admin'
default['jenkins_server']['admin_fullname'] = 'admin'
default['jenkins_server']['admin_email'] = 'admin'
default['jenkins']['server']['home']='/var/lib/jenkins'
default['jenkins_server']['username']="devops_vm_admin"

default['jenkins_server']['credentail_id'] = 'admin'
default['jenkins_server']['credentail_description'] = 'ssh key for jenkins server'
default['jenkins_server']['admin_fullname'] = 'admin'

default['jenkins_server']['reconfig'] = false


default['jenkins_agent']['jenkins_agent_ip'] = '20.185.222.163'
default['jenkins_agent']['jenkins_agent_user'] = 'devops_vm_agent'
default['jenkins_agent']['jenkins_server_user'] = 'devops_vm_admin'
default['jenkins_ssh_slave']['remote_fs']= "/home/devops_vm_agent"

# For further information, see the Chef documentation (https://docs.chef.io/attributes).
