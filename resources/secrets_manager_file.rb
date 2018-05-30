actions :create, :create_if_missing, :touch, :delete

state_attrs :backup,
            :bucket,
            :checksum,
            :group,
            :mode,
            :owner,
            :path,
            :secret_name

attribute :path, :kind_of => String, :name_attribute => true
attribute :secret_name, :kind_of => String
attribute :bucket, :kind_of => String
attribute :owner, :regex => Chef::Config[:user_valid_regex]
attribute :group, :regex => Chef::Config[:group_valid_regex]
attribute :mode, :kind_of => [String, Integer, NilClass], :default => nil
attribute :checksum, :kind_of => [String, NilClass], :default => nil
attribute :backup, :kind_of => [Integer, FalseClass], :default => 5

version = Chef::Version.new(Chef::VERSION[/^(\d+\.\d+\.\d+)/, 1])
if version.major > 11 || (version.major == 11 && version.minor >= 6)
  attribute :headers, :kind_of => Hash, :default => nil
  attribute :use_etag, :kind_of => [TrueClass, FalseClass], :default => true
  attribute :use_last_modified, :kind_of => [TrueClass, FalseClass], :default => true
  attribute :atomic_update, :kind_of => [TrueClass, FalseClass], :default => true
  attribute :force_unlink, :kind_of => [TrueClass, FalseClass], :default => false
  attribute :manage_symlink_source, :kind_of => [TrueClass, FalseClass], :default => nil
end

def initialize(*args)
  super
  @action = :create
  @path = name
end
