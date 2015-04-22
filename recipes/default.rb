#
# Cookbook Name:: jlaws
# Recipe:: default
#
include_recipe 'build-essential::default'

zlib = package 'zlib1g-dev' do
  action :install
end
zlib.run_action(:install)

c = chef_gem 'aws-sdk-v1' do
  action :install
  version node['jlaws']['aws_sdk_ver']
  # Use force to make a side by side gem install work with aws-sdk < 2.0
  # (The aws cookbook use the v2 sdk)
  options('--no-wrappers --force')
end
c.run_action(:install)

require 'aws-sdk-v1'
