#
# Cookbook Name:: mailman3
# Recipe:: default
#
# Copyright 2013, Xu Wang
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "python"
include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

# Get mailman3 auth admin/root pwd from encrytpted data_bag:
if Chef::Config[:solo]
  Chef::Log.warn "This recipe uses encrypted data bags. Chef Solo does not support this."
else
  if node['mailman3']['encrypted_data_bag']['name']
    data_bag_name = node['mailman3']['encrypted_data_bag']['name']
    node['mailman3']['password'] = Chef::EncryptedDataBagItem.load(data_bag_name, "mailman3")
  end
end

# Enable mod_wsgi
apache_module "wsgi" do
  enable true
end

#set up apache2 mailman3 vhost
template "/etc/apache2/sites-available/mailman3" do
  user "root"
  source "mailman3-vhost.conf.erb"
end

apache_site "mailman3"

# Disable the default apache site
apache_site "000-default" do
  enable false
end

# Install django with social-auth
%w{
  django
  django-social-auth
  }.each do |pkg|
      python_pip pkg do
        action :install
      end
  end
  
bash "Download postorius" do
    user "#{node['mailman3']['user']}"
    group "#{node['mailman3']['group']}"
    code <<-EOH
      cd #{node['mailman3']['install_dir']}
      bzr branch lp:postorius
    EOH
    creates "#{node['mailman3']['install_dir']}/postorius"
end

bash "Download postorius_standalone" do
    user "#{node['mailman3']['user']}"
    group "#{node['mailman3']['group']}"
    code <<-EOH
        cd #{node['mailman3']['install_dir']}
        bzr branch lp:~mailman-coders/postorius/postorius_standalone
        EOH
    creates "#{node['mailman3']['install_dir']}/postorius_standalone"
end

bash "Download mailman.client" do
    user "#{node['mailman3']['user']}"
    group "#{node['mailman3']['group']}"
    code <<-EOH
        cd #{node['mailman3']['install_dir']}
        bzr branch lp:mailman.client
        EOH
    creates "#{node['mailman3']['install_dir']}/mailman.client"
end

bash "Install web UI" do
  user "#{node['mailman3']['user']}"
  group "#{node['mailman3']['group']}"
  code <<-EOH
      cd #{node['mailman3']['install_dir']}/mailman.client
      python setup.py install
      cd #{node['mailman3']['install_dir']}/postorius
      python setup.py develop
      cd #{node['mailman3']['install_dir']}/postorius_standalone
      python setup.py install
      python manage.py syncdb --noinput
      EOH
  notifies :restart, resources(:service => "mailman")    
  notifies :restart, resources(:service => "apache2")
end

# Try to set django admin pwd, if it's available
template "#{node['mailman3']['install_dir']}/postorius_standalone/set_admin_passwd.py" do
  owner "#{node['mailman3']['user']}"
  group "#{node['mailman3']['group']}"
  source "set_admin_passwd.py.erb"
  mode 0700
end

bash "Set admin password" do
  user "#{node['mailman3']['user']}"
  code <<-EOH
  cd #{node['mailman3']['install_dir']}/postorius_standalone
  python set_admin_passwd.py #{node['mailman3']['db_admin']} #{node['mailman3']['password']}
  EOH
  only_if { node['mailman3']['password'] }
end

