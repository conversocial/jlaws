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
  # Force to ensure we remove the old aws-sdk binary
  options(:force => true)
end
c.run_action(:install)

require 'aws-sdk-v1'
