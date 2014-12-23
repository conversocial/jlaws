include_recipe 'jlaws'

instances = Chef::Recipe::Jlaws.AsgNodes(
  'prod-solr-da-cluster',
  node['aws_access_key_id'],
  node['aws_secret_access_key'])


instances.each do |instance|
  log "instance id: #{instance[:instance_id]}"

  ip = Chef::Recipe::Jlaws.Ec2InstancePrivateIp(
    instance[:instance_id],
    node['aws_access_key_id'],
    node['aws_secret_access_key'])

  log "Instance: #{instance[:instance_id]} has private ip #{ip}"

  instance_deat = Chef::Recipe::Jlaws.Ec2InstanceInfo(
    instance[:instance_id],
    node['aws_access_key_id'],
    node['aws_secret_access_key'])

  log "Instance: #{instance[:instance_id]} has private dns name #{instance_deat[:private_dns_name]}"
end
