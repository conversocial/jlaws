# jlaws cookbook

Uses the AWS ruby SDK gem to interact with AWS because I got tired of chasing bugs in other cookbooks.

It is designed to use the IAM instance profiles assigned to EC2 instances. Currently it doesn't support
providing AWS credentials to resources directly

# Requirements

Installs the aws-sdk gem.

# Usage

include_recipe "jlaws" to make LWRPs available for use.

jlaws_s3_file '/var/files/from/s3/mylocalfile.txt'
 bucket      'my-s3bucket'
 remote_path 'folder/mys3file.txt'
end

# Author
Author:: James Legg (<james.legg@conversocial.com>)
