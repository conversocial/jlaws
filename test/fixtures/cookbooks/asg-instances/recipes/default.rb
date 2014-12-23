include_recipe 'jlaws'

instances = Chef::Recipe::Jlaws.AsgNodes(
  'prod-solr-da-cluster',
  node['aws_access_key_id'],
  node['aws_secret_access_key'])


instances.each do |instance|
  log "instance id: #{instance[:instance_id]}"

  ip = Chef::Recipe::Jlaws.ec2_instance_private_ip_address(
    instance[:instance_id],
    node['aws_access_key_id'],
    node['aws_secret_access_key'])

  log "Instance: #{instance[:instance_id]} has private ip #{ip}"

  instance_deat = Chef::Recipe::Jlaws.ec2_instance(
    instance[:instance_id],
    node['aws_access_key_id'],
    node['aws_secret_access_key'])

  log "Instance: #{instance[:instance_id]} has private dns name #{instance_deat[:private_dns_name]}"
end
