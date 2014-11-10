#
# Cookbook Name:: jlaws
# Recipe:: default
#
include_recipe 'build-essential::default'

zlib = package 'zlib1g-dev' do
  action :install
end
zlib.run_action(:install)

c = chef_gem 'aws-sdk' do
  action :install
  version node['jlaws']['aws_sdk_ver']
end
c.run_action(:install)

require 'aws-sdk'
