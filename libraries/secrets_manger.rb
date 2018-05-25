class Chef::Recipe::Jlaws
  # Retrieve a secret Secrets Manager using an EC2 instances IAM credentials
  def self.SecretsManager(secret_id)
    sm = AWS::SecretsManager.new()
    sm.get_secret_value(secret_id: secret_id)
  end
end
