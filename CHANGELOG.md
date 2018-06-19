### 1.0.2
  - Use the --no-wrapper option to gem install to prevent conflicts when using
    multiple version of the same gem.

### 1.0.1
  - Make sure minimum version of aws-sdk-resources is installed

### 1.0.0
  - Use aws-sdk v3
  - Add support for AWS secrets manger

### 0.3.0
  - Support more versions of build-essential
  - Improve reliability of tests by running apt-update before them

### 0.2.1
  - Support detecting AWS region from ohai data.

### 0.2.0
  - Basic support for RHEL variants to make things work on AWS linux

### 0.1.7
  - ONLY try and lock nokogiri if it's in the recipe list

### 0.1.6
  Bug Fixes
  - The xml cookbook has locked nokogiri to a specific version.
    Installing aws-sdk-v1 gem at compile times conflict with this and breaks
    any system that tries to use xml cookbook >= 1.28. The route53 cookbook
    depends on xml.
    Detect xml's pinning and install the same version of nokogiri.


### 0.1.4
  Bug Fixes
  - Still need to force install of aws-sdk-v1, but should now co-exist with
    aws-sdk V2 gem OK

### 0.1.4
  Bug Fixes
  - Don't force, just don't install bin wrappers

### 0.1.3
  Bug Fixes
  - Force the install of aws-sdk-v1 so we don't fail on systems running
    older version of this cookbook

### 0.1.2
  Bug Fixes
  - Update version of aws-sdk-v1
### 0.1.1
  Bug Fixes
  - Be specific about installing and using aws-sdk-v1
  - Correct the previous entry version number from 1.7 to 1.0 in this file

### 0.1.0

## Enhancements
  - Add library to extend existing chef resource using not_if and only_if.
    Includes: instance_running?, intance_stopped?,
    instance_terminated?, instance_stopping?
