require_relative 'spec_helper'

describe "Secrets written to files" do
  describe file("/tmp/jlaws_secret1.txt") do
    its(:content) { should match "my secret value" }
  end
  describe file("/tmp/jlaws_secret2.txt") do
    its(:content) { should match "my secret value" }
  end
end
