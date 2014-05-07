#
# Cookbook Name:: jlaws
# Recipe:: default
#
c =chef_gem "aws-sdk" do
  action :install
  version node['jlaws']['aws_sdk_ver']
end
c.run_action(:install)

require 'aws-sdk'
