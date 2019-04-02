include_recipe 'jlaws'
Chef::Resource::Log.send(:include, JlawsHelper)

log "Node i-015745ebceae7ab40 (leeroy) is running!" do
  only_if { instance_running?('i-015745ebceae7ab40',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end

# Node is NOT terminated - dosen't log this
log "Node i-015745ebceae7ab40 is terminated!" do
  only_if { instance_terminated?('i-015745ebceae7ab40',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end

# Node does not exist
log "Node i-1111111 is not logged as it does not exist!" do
  only_if { instance_terminated?('i-111111',
                       node['aws_access_key_id'],
                       node['aws_secret_access_key']) }
end
