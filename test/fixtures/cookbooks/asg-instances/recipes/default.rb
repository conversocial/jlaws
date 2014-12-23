include_recipe 'jlaws'

#Chef::Resource::Log.send(:include, Jlaws::ASG)

instances = Chef::Recipe::Jlaws.AsgNodes(
  'prod-solr-da-cluster-ProdSolrDaServerGroup-LG7CV1KUL14V',
  node['aws_access_key_id'],
  node['aws_secret_access_key'])


log "sheeps #{instances}"
instances.each do |instance|
  log " dogs #{instance}"
  log " cows #{instance['instance_id']}"
end


instances = Chef::Recipe::Jlaws.AsgNodes(
  'prod-solr-da-cluster',
  node['aws_access_key_id'],
  node['aws_secret_access_key'])

log "stuffs #{instances}"

