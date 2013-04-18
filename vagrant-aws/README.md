Building a AWS EC2 mailman3 development VM with Vagrant
-------

1. Setup AWS account at http://aws.amazon.com/account
	* create and download client keys for mailman3 EC2 instances
	* create a security group "mm3" for mailman2 instance, i.e. open ssh, http, smtp ports, etc.

2. Install Vagrant 1.1.5

	> $ gem install vagrant
	> $ vagrant plugin install vagrant-aws

3.  Setup vagrantfile

	> $ cd mailman3-vbox/vagrant-aws
	> $ vagrant init
	> $ cp ./Vagrantfile.ec2 Vagrantfile

	Modify Vagrantfile with your AWS setup, i.e. *aws_access_key_id, aws_secret_access_key, security group, and aws zone*, etc

4. Launch & provision VM

	> $ vagrant up --provider=aws

5. open postorius at 

	> http://ec2.fqdn

	or login into the ec2 instance:

	> $ vagrant ssh 