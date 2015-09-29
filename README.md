# Description #

This cookbook sets up a Rally/Tempest server.

# Requirements #

Chef 11 with Ruby 1.9.x required.

# Platforms #

* RHEL/CentOS 7.0

# Cookbooks #

The following cookbooks are dependencies:

* database

# Usage #

The usage of this cookbook is optional, you may choose to set up your own databases without using this cookbook. If you choose to do so, you will need to do the following:

* create the schema specified by the `openstack-db` recipe.
* create and upload encrypted data bags into your chef environment, as
  specified by `#get_password` in the `openstack-db` recipe.

# Resources/Providers #

None

# Templates #

None

# Recipes #

## default ##

- installs Rally from source

# Attributes #

See attributes/default.rb

Testing
=====

Please refer to the [TESTING.md](TESTING.md) for instructions for testing the cookbook.

Berkshelf
=====

Berks will resolve version requirements and dependencies on first run and
store these in Berksfile.lock. If new cookbooks become available you can run
`berks update` to update the references in Berksfile.lock. Berksfile.lock will
be included in stable branches to provide a known good set of dependencies.
Berksfile.lock will not be included in development branches to encourage
development against the latest cookbooks.

License and Author
==================

|                      |                                                    |
|:---------------------|:---------------------------------------------------|
| **Author**           |  Travis Killoren (<Travis.Killoren@target.com>)    |
|                      |                                                    |
| **Copyright**        |  Copyright (c) 2015, Target                        |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
