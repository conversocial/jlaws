require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end


describe "Install aws-sdk gem" do
  describe command("/opt/chef/embedded/bin/gem specification aws-sdk version | awk '/version/ { print $2}'") do
    it { should return_stdout "1.39.0" }
  end
end
