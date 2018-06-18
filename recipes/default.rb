#
# Cookbook Name:: jlaws
# Recipe:: default
#
chef_gem 'aws-sdk' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_ver']
  # Use force to make a side by side gem install work with aws-sdk < 2.0
  # (The aws cookbook use the v2 sdk)
  options('--no-wrappers --force')
end

chef_gem 'aws-sdk-resources' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_resources_ver']
  # --conservative to not upgrade existing gems meeting version
  options('--conservative')
end

require 'aws-sdk'
