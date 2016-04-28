#
# Cookbook Name:: openstack-rally
# Recipe:: node_prepare
#
# Copyright 2015, Travis Killoren
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


include_recipe 'yum-epel'

# Install Rally prerequisite packages
%w(gcc libffi-devel python-devel openssl-devel gmp-devel libxml2-devel libxslt-devel postgresql-devel git wget python-pip redhat-rpm-config).each do |pkg|
  yum_package pkg do
    action :install
  end
end

execute 'Install rally from git' do
  command 'wget -q -O- https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh | bash'
  creates '/usr/bin/rally'
  action :run
end
