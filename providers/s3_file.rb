def whyrun_supported?
  true
end

action :create do
  do_s3_file(:create)
  new_resource.updated_by_last_action(true)
end

action :create_if_missing do
  do_s3_file(:create_if_missing)
  new_resource.updated_by_last_action(true)
end

action :delete do
  do_s3_file(:delete)
  new_resource.updated_by_last_action(true)
end

action :touch do
  do_s3_file(:touch)
  new_resource.updated_by_last_action(true)
end

def do_s3_file(resource_action)
  content = fetch_s3_content()
  file new_resource.name do
    path new_resource.path
    content content
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    backup new_resource.backup
    action resource_action
  end
end

def fetch_s3_content()
  aws_region = node.key?('aws_region') ? node['aws_region'] : 'us-east-1'
  Chef::Recipe::Jlaws.S3DataBagSecret(
    new_resource.bucket,
    new_resource.remote_path,
    node['aws_access_key_id'],
    node['aws_secret_access_key'],
    aws_region,
    new_resource.mock
  )
end
