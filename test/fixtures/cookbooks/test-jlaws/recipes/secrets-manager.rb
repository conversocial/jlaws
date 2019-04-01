include_recipe 'jlaws'

s3_secret = Jlaws.S3DataBagSecret(
  'conversocial-dev',
  'jameslegg/s3_secret_test_example',
  node['aws_access_key_id'],
  node['aws_secret_access_key']
)
log "The secret from S3 is #{s3_secret}"
file '/tmp/jlaws_s3_secret1.txt' do
  content s3_secret
end

s3_secret = Jlaws.S3DataBagSecret(
  'conversocial-dev',
  'jameslegg/s3_secret_test_example',
  node['aws_access_key_id'],
  node['aws_secret_access_key'],
  nil, 'ABC'
)
log "The secret from S3 is #{s3_secret}"
file '/tmp/jlaws_s3_secret2.txt' do
  content s3_secret
end

jlaws_s3_file '/tmp/jlaws_s3_file1.txt' do
  bucket 'conversocial-dev'
  remote_path 'jameslegg/s3_secret_test_example'
end

jlaws_s3_file '/tmp/jlaws_s3_file2.txt' do
  bucket 'conversocial-dev'
  remote_path 'jameslegg/s3_secret_test_example'
  mock 'ABC'
end

jlaws_secrets_manager_file '/tmp/jlaws_sm_file1.txt' do
  secret_name 'test/jlaws/example'
end

jlaws_secrets_manager_file '/tmp/jlaws_sm_file2.txt' do
  secret_name 'test/jlaws/example'
  mock 'ABC'
end

secret = Jlaws.SecretsManager('test/jlaws/example',
                              node['aws_access_key_id'],
                              node['aws_secret_access_key']
                             )
log "The secret from AWS Secrets Manager is #{secret}"
file '/tmp/jlaws_sm_secret1.txt' do
  content secret
end

secret = Jlaws.SecretsManager('test/jlaws/example',
                              node['aws_access_key_id'],
                              node['aws_secret_access_key'],
                              nil, 'ABC'
                             )
log "The secret from AWS Secrets Manager is #{secret}"
file '/tmp/jlaws_sm_secret2.txt' do
  content secret
end
