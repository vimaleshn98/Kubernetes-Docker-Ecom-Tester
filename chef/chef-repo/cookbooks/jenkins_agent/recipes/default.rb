# This is a Chef Infra recipe file. It can be used to specify resources which will
# apply configuration to a server.

# jenkins-agent::default recipe

# Install Java (required for Jenkins agent)


include_recipe 'jenkins_agent::jdk_setup'
# include_recipe 'jenkins_agent::jenkin_agent'

