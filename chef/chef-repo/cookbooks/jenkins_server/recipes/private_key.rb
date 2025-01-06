require 'net/ssh'

# Fetch the private key from the data bag
ssh_private_key = data_bag_item('jenkins_secrets', 'jenkins_server_ssh')['private_key']

# Ensure the private key content is valid
raise 'Private key is empty or invalid!' if ssh_private_key.nil? || ssh_private_key.strip.empty?


service 'jenkins' do
  action :restart  # Only restart when notified
  ignore_failure true
  only_if { node['jenkins_server']['reconfig'] == true }
  notifies :run, 'ruby_block[sleep_after_restart]', :immediately
end

ruby_block 'sleep_after_restart' do
  block do
    sleep 10  # Delay for 30 seconds
  end
  action :nothing  # Only run when notified
end


jenkins_private_key_credentials node['jenkins_agent']['jenkins_agent_user'] do
  id node['jenkins_agent']['jenkins_agent_user']
  description 'Private key used for authentication'
  private_key ssh_private_key
  # notifies :restart, 'service[jenkins]', :immediately
  only_if { node['jenkins_server']['reconfig'] == true }
end



# Create and use a temporary file for the private key
# begin
#   Tempfile.create('private_key') do |tempfile|
#     tempfile.write(ssh_private_key)
#     tempfile.rewind

#     # Load the private key
#     private_key = Net::SSH::KeyFactory.load_private_key(tempfile.path)
#     private_key_str=private_key.to_s

#     # Define Jenkins credentials
#     jenkins_private_key_credentials node['jenkins_server']['credentail_id'] do
#       id          node['jenkins_server']['credentail_id']
#       description node['jenkins_server']['credentail_description']
#       private_key private_key_str
#     end
#   end
# rescue StandardError => e
#   raise "An error occurred: #{e.message}"
# end
