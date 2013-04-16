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

cookbook_file "/tmp/test_list_members" do
  mode 0644
  source "test_list_members"
end

bash "test" do
      user "#{node['mailman3']['user']}"
      code <<-EOH
      mailman lists | grep "mylist"
      if [ $? == 0 ]; then 
          mailman remove mylist@#{node['mailman3']['server_name']}
      fi
      mailman create -o xuwang@gmail.com -d mylist@#{node['mailman3']['server_name']}
      mailman members -a /tmp/test_list_members mylist@#{node['mailman3']['server_name']}
      mailman lists > /tmp/mailman_list
      mailman members  mylist@#{node['mailman3']['server_name']} > /tmp/mailman_list_members 
      EOH
end

