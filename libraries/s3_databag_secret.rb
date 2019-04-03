class Chef::Recipe::Jlaws
  # Retrieve a specified file from S3 using an EC2 instances IAM credentials
  # It's designed for retrieving encrypted data bag keys
  def self.S3DataBagSecret(s3_bucket, s3_path,
                           aws_access_key_id = nil,
                           aws_secret_access_key = nil,
                           aws_region = nil,
                           mock = nil
                          )
    # Support mocking results for cookbook testing.
    unless mock.nil?
      return mock
    end

    # Fetch secret from AWS.
    aws_region ||= 'us-east-1'
    if aws_access_key_id
      s3 = Aws::S3::Client.new(
        :access_key_id => aws_access_key_id,
        :secret_access_key => aws_secret_access_key,
        :region => aws_region
      )
    else
      s3 = Aws::S3::Client.new(:region => aws_region)
    end
    s3_object = s3.get_object({
      bucket: s3_bucket,
      key: s3_path
    })
    s3_object.body.string()
  end
end
