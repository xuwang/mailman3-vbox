Building a AWS EC2 mailman3 development VM with Vagrant
-------

  1) Setup AWS account at http://aws.amazon.com/account
	 1.1 set env vars:
		set aws_access_key_id to ENV['AWS_ID]
		set aws_secret_access_key to ENV['AWS_SECRET']
	 1.2 create and download client keys for mailman3 EC2 instances
	
  2) Install Vagrant 1.1.5

    $ gem install vagrant
	$ vagrant plugin install vagrant-aws
	
  3) Setup vagrantfile

	$ cd mailman3-vbox/vagrant-aws
	$ vagrant init
	$ cp ./Vagrantfile.ec2 Vagrantfile
	
	Modify Vagrantfile with your AWS setup

  4) Launch & provision VM
	
	$ vagrant up --provider=aws
	
  5) open postorius at http://<ec2.fqdn>, or login into the ec2 instance:
	$ vagrant ssh 