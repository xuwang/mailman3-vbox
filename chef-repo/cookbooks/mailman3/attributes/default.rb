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

default['mailman3']['user'] = 'root'
default['mailman3']['group'] = 'root'
default['mailman3']['db_admin'] = 'admin'
default['mailman3']['server_name'] = 'list.your-org.org'
default['mailman3']['install_dir'] = '/opt'
default['mailman3']['var_dir'] = '/var/lib/mailman'
default['mailman3']['home'] = '/opt/mailman'
default['mailman3']['config_dir'] = '/etc'
default['mailman3']['test_list'] = 'test_list@your-org.org'
default['mailman3']['test_owner'] = 'mm3tester@your-org.org'