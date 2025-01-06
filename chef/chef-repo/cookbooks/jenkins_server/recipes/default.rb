#
# Cookbook:: jenkins_server
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Install required packages for building native extensions

apt_update 'update' do
  ignore_failure true
  action :update
end

# gem_package 'ed25519' do
#   version '1.3.0'
#   action :install
# end

# gem_package 'bcrypt_pbkdf' do
#   action :install
# end
