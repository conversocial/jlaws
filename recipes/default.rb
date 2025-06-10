#
# Cookbook Name:: jlaws
# Recipe:: default
#
chef_gem 'aws-eventstream' do
  action :install
  compile_time true
  version node['jlaws']['aws_eventstream_ver']
end

chef_gem 'aws-sigv4' do
  action :install
  compile_time true
  version node['jlaws']['aws_sigv4_ver']
end

chef_gem 'aws-partitions' do
  action :install
  compile_time true
  version node['jlaws']['aws_partitions_ver']
end

chef_gem 'aws-sdk-core' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_core_ver']
end

chef_gem 'aws-sdk-kms' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_kms_ver']
end

chef_gem 'aws-sdk-s3' do
  action :install
  compile_time true
  version node['jlaws']['aws_sdk_s3_ver']
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


require 'aws-eventstream'
require 'aws-sdk-core'
require 'aws-sdk-s3'
require 'aws-sdk-secretsmanager'
require 'aws-sdk-ec2'
