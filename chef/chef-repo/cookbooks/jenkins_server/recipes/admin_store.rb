# new_password = data_bag_item('jenkins_secrets', 'admin_password')['password']

# Create the Jenkins admin user with the password from the data bag
# jenkins_user node['jenkins_server']['admin'] do
#   password jenkins_password  # Set the password from the data bag
#   full_name node['jenkins_server']['admin_fullname']
#   email node['jenkins_server']['admin_email']
#   jenkins_url 'http://localhost:8080'  # URL to your Jenkins instance
#   action :create
# end



# Optionally, if Jenkins is locked, ensure that the initial password file is deleted
jenkins_home = node['jenkins']['server']['home']

initial_password_file = "#{jenkins_home}/secrets/initialAdminPassword"

# Check if the initial password file exists and reset Jenkins
if ::File.exist?(initial_password_file)
  # Read the initial password from the file (if the Jenkins setup is not complete)
  initial_admin_password = IO.read(initial_password_file).strip
  Chef::Log.info("Initial Jenkins Admin password: #{initial_admin_password}")

  # Define the data bag and item names
  data_bag_name = 'jenkins_secrets'
  data_bag_item_name = 'admin_password'

  # Define the new data to add
  updated_user_data = {
    'password' => initial_admin_password  # Updated email
  }

  # Load the existing data bag item and update it
  ruby_block 'update_admin_in_databag' do
    block do
      # Load the existing data bag item
      item = data_bag_item(data_bag_name, data_bag_item_name)
      
      # Merge the new data into the existing data bag item
      item.merge!(updated_user_data)
      
      # Save the updated item back to the Chef server
      item.save
    end
    action :run
  end   

  # You can delete this file once Jenkins is set up, to indicate it has been unlocked
  file initial_password_file do
    action :delete
    notifies :restart, 'service[jenkins]', :immediately
  end
end
 

# Restart Jenkins to apply any changes made to the user configuration
service 'jenkins' do
  action :nothing  # Only restart when notified
end

