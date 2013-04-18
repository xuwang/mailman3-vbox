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

# Install base packages for mailman3
%w{
  bzr
  postfix
  openssl-blacklist
  ssl-cert
  }.each do |pkg|
    package pkg
  end

# Install mm3 required zope version   
python_pip "zope.interface" do
  version "4.0.5"
  action :install
end

bash "Download mailman" do
    user "#{node['mailman3']['user']}"
    group "#{node['mailman3']['group']}"
    code <<-EOH
        cd #{node['mailman3']['install_dir']}
        bzr branch lp:mailman
        EOH
    creates node['mailman3']['home']
end

bash "Install mailman3" do
  user "#{node['mailman3']['user']}"
  group "#{node['mailman3']['group']}"
  code <<-EOH
  cd #{node['mailman3']['home']}
  python setup.py install
  EOH
end

# Install mailman conf file
service "mailman" do
  supports :start => true, :stop => true, :restart => true, :reload => true
  action :nothing
end 

template "mailman" do
  path "/etc/init.d/mailman"
  source "mailman.d.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, resources(:service => "mailman")
end

template "#{node['mailman3']['config_dir']}/mailman.cfg" do
  mode 0440
  owner node['mailman3']['user']
  group node['mailman3']['group']
  variables(
    'mailman3_config' => node['mailman3']
  )
  notifies :reload, resources(:service => "mailman")
end

# Install Postfix hook for Mailman
service "postfix" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

postfixHook = <<EOF
# Mailman hook
recipient_delimiter = +
unknown_local_recipient_reject_code = 550
owner_request_special = no
transport_maps = hash:#{node['mailman3']['var_dir']}/data/postfix_lmtp
local_recipient_maps = hash:#{node['mailman3']['var_dir']}/data/postfix_lmtp
relay_domains = hash:#{node['mailman3']['var_dir']}/data/postfix_domains
EOF


ruby_block "Install Postfix hook for Mailman" do
  block do
    file = Chef::Util::FileEdit.new("/etc/postfix/main.cf")
    file.insert_line_if_no_match(/# Mailman hook/, postfixHook)
    file.write_file
  end
  notifies :reload, resources(:service => "postfix"), :immediately
end
