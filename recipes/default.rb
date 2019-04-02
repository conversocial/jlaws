#
# Cookbook Name:: jlaws
# Recipe:: default
#
chef_gem 'aws-sdk-s3' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_resources_s3_ver']
end

chef_gem 'aws-sdk-secretsmanager' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_secrets_manager_ver']
end

chef_gem 'aws-sdk-ec2' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_ec2_ver']
end

require 'aws-sdk-s3'
require 'aws-sdk-secretsmanager'
require 'aws-sdk-ec2'
