# jlaws cookbook

Uses the AWS ruby SDK gem to interact with AWS because I got tired of chasing bugs in other cookbooks.

It is designed to use the IAM instance profiles assigned to EC2 instances. Currently it doesn't support
providing AWS credentials to resources directly

# Requirements

Installs the aws-sdk gem and it's dependencies at compile time.

# Usage

To make LWRPs available for use and install the aws-sdk gem:

  include_recipe "jlaws"

## Resources
### jlaws_s3_file

The supports the same attributes as the [file](http://docs.opscode.com/resource_file.html) resource.

```
  jlaws_s3_file '/var/files/from/s3/mylocalfile.txt'
    bucket      'my-s3bucket'
    remote_path 'folder/mys3file.txt'
  end
```

### jlaws_secrets_manager_file

The supports the same attributes as the [file](http://docs.opscode.com/resource_file.html) resource.

```
  jlaws_secrets_manger_file '/var/files/from/s3/mylocalfile.txt'
    secret_path 'aws/secrets/manager/path'
  end
```

## Libraries
### Jlaws.S3DataBagSecret

Alternately to the jlaws_s3_file resource if you need to use the contents of an
S3 file during a chef run you may do the following:

```
secret = Jlaws.S3DataBagSecret(
  'my-s3-bucket',
  'databag-keys-folder/my_data_bag_secret'
)
data_bag_item = Chef::EncryptedDataBagItem.load('my_data_bag', 'item', secret)
```

### Jlaws.S3DataBagSecret

Alternately to the jlaws_secrets_manager_file resource if you need to use the contents of an
secret during a chef run you may do the following:

```
secret = Jlaws.AWSSecretManager('aws/secrets/manager/path')
data_bag_item = Chef::EncryptedDataBagItem.load('my_data_bag', 'item', secret)
```

### Check ec2 instance status in AWS

Extend existing Chef Resources and base actions on the following checks:
 * node_running?('id-1111111')
 * node_stopped?('id-2222222')
 * node_stopping?('id-333333')
 * node_terminated?('id-444444')

Example extending Log resource:
```
include_recipe 'jlaws'
Chef::Resource::Log.send(:include, Jlaws::Helper)

log "Node i-42273d11 is running!" do
  only_if { instance_running?('i-42273d11') }
end
```

# Testing

Some local testing can be done with test-kitchen. To test AWS instance statuses
you must first export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.

# Author
Author:: James Legg (<james.legg@conversocial.com>)
