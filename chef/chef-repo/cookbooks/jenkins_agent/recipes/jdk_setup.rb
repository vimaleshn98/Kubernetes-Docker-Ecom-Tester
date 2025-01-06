package "openjdk-#{node['jenkins_agent']['jdk_version']}-jdk" do
  action :install
end

# Set JAVA_HOME environment variable globally
bash 'set_java_home' do
  code <<-EOH
    echo 'export JAVA_HOME=/usr/lib/jvm/java-#{node['jenkins_agent']['jdk_version']}-openjdk-amd64' >> /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
  EOH
  not_if "grep 'JAVA_HOME' /etc/profile"
end

# Ensure JAVA_HOME is available in the session for the user
bash 'set_java_home_for_user' do
  code <<-EOH
    echo 'export JAVA_HOME=/usr/lib/jvm/java-#{node['jenkins_agent']['jdk_version']}-openjdk-amd64' >> /home/#{node['jenkins_agent']['username']}/.bashrc
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/#{node['jenkins_agent']['username']}/.bashrc
  EOH
  not_if "grep 'JAVA_HOME' /home/#{node['jenkins_agent']['username']}/.bashrc"
  user node['jenkins_agent']['username']
end
