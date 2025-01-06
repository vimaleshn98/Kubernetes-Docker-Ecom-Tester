ansible-playbook -i inventory/hosts.ini install_jenkins_plugins.yml
ansible-playbook -i inventory/hosts.ini configure_jenkins_job.yml
ansible-playbook -i inventory/hosts.ini configure_ssh_agent.yml
ansible-playbook -i inventory/hosts.ini docker_and_kubernetes_setup.yml
