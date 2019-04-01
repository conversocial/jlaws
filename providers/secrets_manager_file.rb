def whyrun_supported?
  true
end

action :create do
  do_secrets_file_file(:create)
  new_resource.updated_by_last_action(true)
end

action :create_if_missing do
  do_secrets_file_file(:create_if_missing)
  new_resource.updated_by_last_action(true)
end

action :delete do
  do_secrets_files_file(:delete)
  new_resource.updated_by_last_action(true)
end

action :touch do
  do_secrets_file_file(:touch)
  new_resource.updated_by_last_action(true)
end

def do_secrets_file_file(resource_action)
  sec = fetch_secret_content()
  file new_resource.name do
    path new_resource.path
    content sec
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    backup new_resource.backup
    action resource_action
  end
end

def fetch_secret_content()
  aws_region = node.key?('aws_region') ? node['aws_region'] : 'us-east-1'
  Chef::Recipe::Jlaws.SecretsManager(
    new_resource.secret_name,
    node['aws_access_key_id'],
    node['aws_secret_access_key'],
    aws_region,
    new_resource.mock
  )
end
