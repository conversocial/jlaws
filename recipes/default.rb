#
# Cookbook Name:: jlaws
# Recipe:: default
#
chef_gem "aws-sdk" do
  action :install
  version node['jlaws']['aws_sdk_ver']
end

require 'aws-sdk'
