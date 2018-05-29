include_recipe 'jlaws'
Chef::Resource::Log.send(:include, Jlaws::Helper)

log "Node i-422b873d (leeroy) is running!" do
  only_if { instance_running?('i-422b873d',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end

# Node is stopped
log "Node i-670fc98b is termnated!" do
  only_if { instance_terminated?('i-670fc98b',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end

# Node is NOT terminated - dosen't log this
log "Node i-67b71686 is terminated!" do
  only_if { instance_terminated?('i-67b71686',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end

# Node does not exist
log "Node i-1111111 is not logged as it does not exist!" do
  only_if { instance_terminated?('i-111111',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end
