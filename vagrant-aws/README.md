Building a AWS EC2 mailman3 development VM with Vagrant
=======================================================

Note: tested with vagrant-1.2.1 and plugin vagrant-aws-0.2.2, 
there might be issues if you are using other versions.
Check https://github.com/mitchellh/vagrant-aws for details.

1) Setup AWS account at http://aws.amazon.com/account
----------------
* create a security group "mm3" for mailman3 instance, i.e. open ssh, http, smtp ports, etc.
* create a "mm3" keypair for mailman3 EC2 instances and download the mm3.pem key

Add mm3.pem key to your local SSH key store:

	$ ssh-add ~/.ssh/mm3.pem

2) Install Vagrant 1.2.1
----------------
### for debain on x86_64 ###

	$ cd /tmp
	$ wget http://files.vagrantup.com/packages/a7853fe7b7f08dbedbc934eb9230d33be6bf746f/vagrant_1.2.1_x86_64.deb
	$ sudo dpkg -i vagrant_1.2.1_x86_64.deb 
	
### for mac os x ###

	download http://files.vagrantup.com/packages/a7853fe7b7f08dbedbc934eb9230d33be6bf746f/Vagrant-1.2.1.dmg
	and isntall
	
### for windows ###

	download http://files.vagrantup.com/packages/a7853fe7b7f08dbedbc934eb9230d33be6bf746f/Vagrant_1.2.1.msi
	and install
	
### for other systems ###
See: [Vagrant v1.2.1 download](http://downloads.vagrantup.com/tags/v1.2.1)
	
3) Setup vagrantfile
-----------------
	$ cd <git-clone-dir>/mailman3-vbox/vagrant-aws
	$ vagrant init
	$ cp ./Vagrantfile.ec2 Vagrantfile

Edit Vagrantfile and set AWS conf vars in the file:
	
	* aws.access_key_id
	* aws.secret_access_key
	* aws.region
	* aws.instance_type
	* aws.ami
	* aws.security_groups
	* aws.keypair_name
	* override.ssh.private_key_path

4) Launch & provision VM
------------------
	$ vagrant up --provider=aws

5) Open postorius at 
-----------------
	http://ec2.fqdn
	
You can find the ec2.fqdn by command:
 
	$ vagrant ssh-config

or login into the ec2 instance:

	$ vagrant ssh 
	
6) Destroy the ec2 instance
-----------------
	
	$ vagrant destroy
