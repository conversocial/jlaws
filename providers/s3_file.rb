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

  s3 = AWS::S3.new()

  s3_file = s3.buckets[new_resource.bucket].objects[new_resource.remote_path]

  file new_resource.name do
    path new_resource.path
    content s3_file.read
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    backup new_resource.backup
    action resource_action
  end
end
