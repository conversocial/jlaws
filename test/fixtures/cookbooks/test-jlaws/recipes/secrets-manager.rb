include_recipe 'jlaws'

s3_secret = Jlaws.S3DataBagSecret(
  'conversocial-dev',
  'jameslegg/s3_secret_test_example',
  node['aws_access_key_id'],
  node['aws_secret_access_key']
)

log "The secret from S3 is #{s3_secret}"

file '/tmp/jlaws_secret1.txt' do
  content s3_secret
end

jlaws_secrets_manager_file '/tmp/jlaws_secret2.txt' do
  secret_name 'test/jlaws/example'
end

secret = Jlaws.SecretsManager('test/jlaws/example',
                              node['aws_access_key_id'],
                              node['aws_secret_access_key']
                             )

log "The secret from AWS Secrets Manager is #{secret}"
