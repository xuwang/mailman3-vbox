Description
===========
This cookbook provides recipes to install Mailman3 development system.
  
See http://wiki.list.org/display/DEV/Mailman+3.0 for Mailman3 development issues.

Requirements
============

* Ubuntu 12.04

Attributes
==========

* `user`  - mailman owner, default to root
* `group`	- mailman group, default to root
* `db_admin` - mailman db admin user, default to admin
* `password` - the mailman db admin's password
* `db_name` - mailman db name, default to mailman3db
* `install_dir` - mailman installation dir, default to /opt
* `var_dir` - mailman var dir, default to /var/mailman/lib
* `home` - mailman home, default to /opt/mailman
* `config_dir` - mailman configuration dir, default to /etc
* `encrypted_data_bag.name` - name of the encrypted data bag containing the default password for
													the mailman db_admin. If set, it will overwrite `node['mailman3']['password']`
													NOT SUPPORTED for chef-solo												
* `test_list` - mailman test_list email address		
* `test_owner` - mailman test_list owner's email address
													

Usage
=====

* `recipe[mailman3]` build the mailman3 core only
* `recipe[mailman3::web]` build the mailman3 postorius web interface
* `recipe[mailman3::test_list]` provision mailman3 test lists

test_list members can be added in files/default/test_list_members


License and Authors
-------------------
* Author:: Xu Wang <xuwang@gmail.com>

* Copyright 2013, Xu Wang

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

