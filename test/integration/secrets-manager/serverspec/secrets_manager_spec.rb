require_relative 'spec_helper'

describe "Secrets written to files" do
  describe file("/tmp/jlaws_s3_secret1.txt") do
    its(:content) { should match "my secret value" }
  end
  describe file("/tmp/jlaws_s3_secret2.txt") do
    its(:content) { should match "ABC" }
  end
  describe file("/tmp/jlaws_s3_file1.txt") do
    its(:content) { should match "my secret value" }
  end
  describe file("/tmp/jlaws_s3_file2.txt") do
    its(:content) { should match "ABC" }
  end
  describe file("/tmp/jlaws_sm_secret1.txt") do
    its(:content) { should match "my secret value" }
  end
  describe file("/tmp/jlaws_sm_secret2.txt") do
    its(:content) { should match "ABC" }
  end
end
