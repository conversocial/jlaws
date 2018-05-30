require_relative 'spec_helper'

describe "Install aws-sdk gem v3" do
  describe command("/opt/chef/embedded/bin/gem specification aws-sdk version | awk '/version/ { print $2}'") do
    its(:stdout) { should match "3.0.1" }
  end
end
