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
