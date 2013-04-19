Building a AWS EC2 mailman3 development VM with Vagrant
=======================================================

1) Setup AWS account at http://aws.amazon.com/account
----------------
* create a security group "mm3" for mailman3 instance, i.e. open ssh, http, smtp ports, etc.
* create a "mm3" keypair for mailman3 EC2 instances and download the mm3.pem key

Add mm3.pem key to your local SSH key store:

	$ ssh-add ~/.ssh/mm3.pem

2) Install Vagrant 1.1.5
----------------
	$ gem install vagrant
	$ vagrant plugin install vagrant-aws

3) Setup vagrantfile
-----------------
	$ cd mailman3-vbox/vagrant-aws
	$ vagrant init
	$ cp ./Vagrantfile.ec2 Vagrantfile

Edit Vagrantfile and set AWS conf vars in the file:
	
	* aws.access_key_id
	* aws.secret_access_key
	* aws.region
	* aws.instance_type
	* region.ami
	* region.keypair_name
	* region.ssh_private_key_path
	* region.security_groups

4) Launch & provision VM
------------------
	$ vagrant up --provider=aws

5) open postorius at 
-----------------
	http://ec2.fqdn
	
You can find the ec2.fqdn by command:
 
	$ vagrant ssh-config

or login into the ec2 instance:

	$ vagrant ssh 
