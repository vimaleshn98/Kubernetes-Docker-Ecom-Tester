
# Install prerequisites for Docker
package %w[apt-transport-https ca-certificates curl software-properties-common] do
  action :install
end

# Add Docker's official GPG key
execute 'add_docker_gpg_key' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
  not_if 'apt-key list | grep Docker'
end

# Add Docker's APT repository
execute 'add_docker_apt_repository' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
  not_if 'grep -R "https://download.docker.com/linux/ubuntu" /etc/apt/sources.list /etc/apt/sources.list.d/*'
end

# Update the package index after adding the Docker repository
execute 'update_docker_repository' do
  command 'apt-get update'
end

# Install Docker
package 'docker-ce' do
  action :install
end

# Create directories for certificates
directory '/etc/docker' do
  action :create
  owner node['jenkins_agent']['username']
  group node['jenkins_agent']['username']
  recursive true
end

# # Generate Docker CA certificate and key
# execute 'create_docker_ca' do
#   command <<-EOH
#     openssl genrsa -out /etc/docker/ca-key.pem 2048
#     openssl req -new -x509 -key /etc/docker/ca-key.pem -out /etc/docker/ca.pem -days 3650 -subj "/CN=Docker-CA"
#   EOH
#   creates '/etc/docker/ca.pem'
# end

# # Generate Docker server certificate and key
# execute 'create_docker_server_cert' do
#   command <<-EOH
#     openssl genrsa -out /etc/docker/server-key.pem 2048
#     openssl req -new -key /etc/docker/server-key.pem -out /etc/docker/server.csr -subj "/CN=docker-server"
#     openssl x509 -req -in /etc/docker/server.csr -CA /etc/docker/ca.pem -CAkey /etc/docker/ca-key.pem -CAcreateserial -out /etc/docker/server-cert.pem -days 3650
#   EOH
#   creates '/etc/docker/server-cert.pem'
# end

# # Generate Docker client certificate and key (optional)
# execute 'create_docker_client_cert' do
#   command <<-EOH
#     openssl genrsa -out /etc/docker/client-key.pem 2048
#     openssl req -new -key /etc/docker/client-key.pem -out /etc/docker/client.csr -subj "/CN=docker-client"
#     openssl x509 -req -in /etc/docker/client.csr -CA /etc/docker/ca.pem -CAkey /etc/docker/ca-key.pem -CAcreateserial -out /etc/docker/client-cert.pem -days 3650
#   EOH
#   creates '/etc/docker/client-cert.pem'
# end



# Update the docker.service systemd unit file using the template
template '/etc/systemd/system/docker.service' do
  source 'docker.service.erb'
  variables(
    docker_exec_start: node['jenkins_agent']['docker_exec_start']
  )
  notifies :run, 'execute[reload systemd]', :immediately
end

execute 'reload systemd' do
  command 'systemctl daemon-reload'
  action :nothing
end

# Configure Docker to use TLS with the generated certificates
template '/etc/docker/daemon.json' do
  source 'daemon.json.erb'
  notifies :restart, 'service[docker]', :immediately
  action :create
end

# Start and enable the Docker service
service 'docker' do
  action [:enable, :start]
end

# Add the Jenkins or desired user to the Docker group for permissions
group 'docker' do
  action :modify
  members node['jenkins_agent']['username']
  append true
end

# Verify Docker installation with a test container
execute 'verify_docker_installation' do
  command 'docker run hello-world'
  only_if { node['docker']['run_test_container'] == true } # Optional attribute
end
