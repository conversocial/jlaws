require 'chefspec'
require 'chefspec/berkshelf'
require 'aws-sdk'

# Require all our libraries
Dir['libraries/*.rb'].each { |f| require File.expand_path(f) }

at_exit { ChefSpec::Coverage.report! }
