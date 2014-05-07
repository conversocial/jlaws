#require 'awk-sdk'

class Chef::Recipe::Jlaws
  # Retrieve a specified file from S3 using an EC2 instances IAM credentials
  # It's designed for retrieving encrypted data bag keys
  def self.S3DataBagSecret(s3_bucket, s3_path)
    s3 = AWS::S3.new()
    s3_file = s3.buckets[s3_bucket].objects[s3_path]
    s3_string = s3_file.read
    s3_string
  end
end
