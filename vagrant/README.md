Building a local mailman3 development VM with Vagrant
-------

  1) Install VirutalBox 
	See: http://www.virtualbox.org/manual/ch02.html

  2) Install vagrant

    $ gem install vagrant

  3) Launch & provision VM

	$ vagrant init
	$ cp ./Vagrantfile.vbox Vagrantfile
	$ vagrant up
	
  4) open postorius at http://localhost:8080