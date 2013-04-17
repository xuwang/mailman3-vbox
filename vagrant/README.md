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


1. Install VirutalBox and Vagrant 1.1.5
-------------

	Follow the instructions on http://docs-v1.vagrantup.com/v1/docs/getting-started

2. Launch & provision VM
---------------

	$ cd mailman3-vbox/vagrant
	$ vagrant init
	$ cp ./Vagrantfile.vbox Vagrantfile
	$ vagrant up
	
Note: depends on your host machine type, you may need to change the config.vm.box_url setting
in the Vagrantfile. A list of available boxes can be found at:
	
	http://www.vagrantbox.es/
	
3. open postorius at http://localhost:8080 or login into the virtual machine:
----------------

	$ vagrant ssh