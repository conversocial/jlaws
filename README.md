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
    secret_name 'aws/secrets/manager/path'
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

### Jlaws.SecretsManager

Alternately to the jlaws_secrets_manager_file resource if you need to use the contents of an
secret during a chef run you may do the following:

```
secret = Jlaws.SecretManager('aws/secrets/manager/path')
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
Chef::Resource::Log.send(:include, JlawsHelper)

log "Node i-42273d11 is running!" do
  only_if { instance_running?('i-42273d11') }
end
```

# Testing

Some local testing can be done with test-kitchen. To test AWS instance statuses
you must first export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.

# Creating an Emergency Release

## Setting up knife

Done in June 2025 as ruby dependencies had drifted and needed Ruby 2.7+. See changes in `v2.0.3`. Allows us to interact with the chef-server to pull/push cookbooks:

  * Launch a new EC2 instance _from a template_ matching the settings of a host in a _backend_ autscaling group. 
    * Choose a network subnet from existing instances 
    * You will want to edit the userdata initialization script under `Advanced Details -> User Data`.
      * Prevent the host from shutting down in `error_exit` function.
      * Do not remove `validation.pem`
      * Comment out `cfn-signal` command at the end to join the ASG.
  * Log `/var/log/cloud-init-output.log` shows the bootstrapping process where the error is likely to be.
  * Install Cinc Workstation; which provides the `knife` tool.
```
curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-workstation -v 24
```
  * Download pem file from https://us-east-1.console.aws.amazon.com/s3/object/conversocial-chef?bucketType=general&prefix=chef-server12-client14-cloudformation.pem&region=us-east-1#
    * Save this in `/etc/chef/key.pem`
    * `chmod 600 /etc/chef/key.pem`
  * Create `/etc/chef/knife_config.rb`:
```
log_level                :info
log_location             STDOUT
node_name                'cloudformation'
client_key               '/etc/chef/key.pem'
chef_server_url          'https://chef-server12-client14.conversocial.com/organizations/conversocial'
cookbook_path            ['/home/jenkins/workspace/']
```
  * Verify
    * `knife environment list -c ./knife_config.rb`
    * Should output:
```
_default
production
sandbox
```

### Example Knife Commands

Be careful pushing new versions as existing production instances may pick them up within 30minutes

```
knife environment list -c ./knife_config.rb
knife cookbook download jlaws -c ./knife_config.rb
knife cookbook upload jlaws -c ./knife_config.rb --cookbook-path .
knife cookbook delete jlaws <VERSION> -c ./knife_config.rb
```

Once you have downloaded existing latest version:
  * Make edits as required
  * Update `metadata.json` with a new version.
  * Upload to chef-server (careful as live may pick it up depending on the version number)
  * If you want to test safely, make a copy of the entire cookbook e.g. `jlaws-test` and then reference it in `bootstrap.json` like this `run_list": ["recipe[jlaws-test]"]`
  * Test by running chef as shown below
  * Make equivalent edits to the files in this git repo locally and merge to master
  * Tag the repo with the version number:
```
git tag vX.Y.Z
git push origin --tags
```

# Running Chef

Used to validate installaton of the gems.
Note you do NOT want `Redirecting to cinc-client` as the version is more recent and does not work. Consider using a host with original chef-client correctly installed.

```
chef-client -E production --once --no-color -j /etc/chef/bootstrap.json -c /etc/chef/client.rb
```

# Author
Author:: James Legg (<james.legg@conversocial.com>)
