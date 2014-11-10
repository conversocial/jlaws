require_relative 'spec_helper'

describe "Install aws-sdk gem" do
  describe command("/opt/chef/embedded/bin/gem specification aws-sdk version | awk '/version/ { print $2}'") do
    its(:stdout) { should match "1.39.0" }
  end
end

describe 'Install zlib1g-dev' do
  describe package('zlib1g-dev') do
    it { should be_installed }
  end
end
