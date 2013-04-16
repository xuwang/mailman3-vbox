Building a AWS EC2 mailman3 development VM with Vagrant
-------

  1) Setup AWS account at http://aws.amazon.com/account
	 1.1 set env vars:
		set aws_access_key_id to ENV['AWS_ID]
		set aws_secret_access_key to ENV['AWS_SECRET']
	 1.2 create and download client keys for mailman3 EC2 instances
	
  2) Install vagrant

    $ gem install vagrant
	$ vagrant plugin install vagrant-aws

  3) Launch & provision VM

	$ vagrant init mm3
	$ cp ./Vagrantfile.ec2 Vagrantfile
	$ vagrant up --provider=aws
	
  4) open postorius at http://<ec2.fqdn>