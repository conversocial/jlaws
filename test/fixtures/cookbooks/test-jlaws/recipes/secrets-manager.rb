include_recipe 'jlaws'

s3_secret = Jlaws.S3DataBagSecret(
  'conversocial-dev',
  'jameslegg/s3_secret_test_example'
)


log "The secret from S3 is #{s3_secret}"

jlaws_secrets_manager_file '/tmp/jlaws_secret.txt' do
  secret_name 'test/jlaws/example'
end

secret = Jlaws.SecretsManager('/tmp/jlaws_secret.txt')

log "The secret from AWS is #{secret}"


