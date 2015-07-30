Building a local mailman3 development VM with Vagrant
=====================
Following mailman3 components will installed on the development virtual machine:

* Mailman3 Core
* init.d mailman service
* Postfix hookup
* Mailman3 test list
* Mailman3 client
* Mailman3 Postorius web interface
* Apache2 mailman virtual host


1. Install VirutalBox and Vagrant
-------------

Follow Vagrant [Getting Started](http://docs-v1.vagrantup.com/v1/docs/getting-started) instructions.
	
Note: for Debian Wheezy system, virtualbox-dkms kernel module is required for VirtualBox:

	$ sudo aptitude install virtualbox-dkms

2. Launch & provision VM
---------------

	$ cd mailman3-vbox/vagrant
	$ vagrant init
	$ cp ./Vagrantfile.vbox Vagrantfile
	$ vagrant up
	
Note: depends on your host machine type, you may need to change the config.vm.box_url setting
in the Vagrantfile. A list of available boxes can be found at:
	
	http://www.vagrantbox.es/
	
This step can take very long time. 
	
3. Open postorius at http://localhost:8080 

The login name is admin. The password is "not-a-secret".

There is a pre-created test list on the first page. 

NOTE: Many other links will generate KeyErrors. These are [known issues](https://bugs.launchpad.net/postorius?field.searchtext=KeyError&search=Search&field.status%3Alist=NEW&field.status%3Alist=INCOMPLETE_WITH_RESPONSE&field.status%3Alist=INCOMPLETE_WITHOUT_RESPONSE&field.status%3Alist=CONFIRMED&field.status%3Alist=TRIAGED&field.status%3Alist=INPROGRESS&field.status%3Alist=FIXCOMMITTED&field.assignee=&field.bug_reporter=&field.omit_dupes=on&field.has_patch=&field.has_no_package=) with postorius/mailmanclient.

4. login into the virtual machine:
----------------

	$ vagrant ssh
	
	
5. Shutdown the virtual machine:
----------------

	$ vagrant halt
	
6. Destroy the virtual machine:
----------------

	$ vagrant box remove mm3 virtualbox
	$ rm -rf .vagrant
	
For more vagrant commands, refer to  [Vagrant command-line interface](http://docs.vagrantup.com/v2/cli/index.html)
 

