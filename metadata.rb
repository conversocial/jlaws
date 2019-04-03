name             'jlaws'
maintainer       'James Legg'
maintainer_email 'mail@jameslegg.co.uk'
license          'Apache 2.0'
description      'provides LWRPs for interaction with AWS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.1'
supports         'ubuntu', '=18.04'
supports         'amazon'

chef_version '~> 14.11.21' if respond_to?(:chef_version)
