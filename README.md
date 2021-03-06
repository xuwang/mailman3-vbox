Description
===========

Build Mailman3 development virtual machines with Vagrant and Chef.

See http://wiki.list.org/display/DEV/Mailman+3.0 for Mailman3 development issues.

Instructions and the Vagrantfile to build a Mailman3 development virtual machine 
is given under the vagrant sub-directory.
	
Following mailman3 components will installed on the development virtual machine:

* Mailman3 Core
* init.d mailman service
* Postfix hookup
* Mailman3 test list
* Mailman3 client
* Mailman3 Postorius web interface
* Apache2 mailman virtual host

The cookbook mailman3 in chef-repo/cookbooks provides recipes to install Mailman3.

Requirements
============
Tested with:

* Ubuntu 12.04/Debian Wheezy/Mac OS X 10.8.x
* Vagrant Vagrant 1.7.2
* VirtualBox 4.3.24
* Chef 12.3.0
													
Usage
=====

Download:

	$ git clone https://github.com/xuwang/mailman3-vbox.git

* To build a mailman3 virtual machine with vagrant, see [vagrant/README.md](https://github.com/xuwang/mailman3-vbox/blob/master/vagrant/README.md).
* To build a Mailman3 virtual machine on AWS EC2, see [vagranet-aws/README.md](https://github.com/xuwang/mailman3-vbox/blob/master/vagrant-aws/README.md).
* For chef mailman3 cookbook usage, see chef-repo/cookbooks/mailman3/README.md.


License and Authors
-------------------
* Author: Xu Wang <xuwang@gmail.com>

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

