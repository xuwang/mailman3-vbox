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
      mailman lists | grep #{node['mailman3']['test_list']}
      if [ $? == 0 ]; then 
          mailman remove #{node['mailman3']['test_list']}
      fi
      mailman create -o #{node['mailman3']['test_owner']} -d #{node['mailman3']['test_list']}
      mailman members -a /tmp/test_list_members #{node['mailman3']['test_list']}
      mailman lists > /tmp/mailman_test_lists
      mailman members  #{node['mailman3']['test_list']} > /tmp/test_list_members 
      EOH
end

