name             'jlaws'
maintainer       'James Legg'
maintainer_email 'mail@jameslegg.co.uk'
license          'Apache 2.0'
description      'provides LWRPs for interaction with AWS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'
# Last version that supports chef 12.5
depends          'build-essential', '<= 7.03'
depends          'apt'
supports         'ubuntu'
