class Chef::Recipe::Jlaws
  # Retrieve a secret Secrets Manager using an EC2 instances IAM credentials
  def self.SecretsManager(secret_id, aws_region = 'us-east-1')
    if aws_access_key_id
      sm = Aws::SecretsManager::Client.new(
        :access_key_id => aws_access_key_id,
        :secret_access_key => aws_secret_access_key,
        :region => aws_region)
    else
      sm = Aws::SecretsManager::Client.new(:region => aws_region)
    end
    sm.get_secret_value(secret_id: secret_id).secret_string
  end
end
