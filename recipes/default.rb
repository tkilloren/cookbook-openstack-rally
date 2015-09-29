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


#case node['platform_family']
#when 'debian'
#  include_recipe 'apt::default'
#
#  apt_repository 'pcs' do
#    uri          node['pcs']['repo']['url']
#    distribution 'binary/'
#    key          node['pcs']['repo']['key']
#  end
#
#  package 'pcs' do
#    version node['pcs']['repo']['pkg_version']
#  end
#when 'rhel'
#  include_recipe 'yum::default'
#
#  yum_repository 'pcs' do
#    baseurl node['pcs']['repo']['url']
#    gpgkey  node['pcs']['repo']['key']
#  end
#
#  package 'pcs' do
#    version node['pcs']['repo']['pkg_version']
#  end
#end

case node['platform_family']
when 'debian'
  include_recipe 'apt::default'
when 'rhel'
  include_recipe 'yum::default'

  yum_repository 'rhel7-2015r1-tgt' do
    description 'Enterprise base'
    baseurl 'http://10.63.216.186:8000/rhel7-2015r1-tgt/'
    gpgcheck false
    action :create
  end

  yum_repository 'rhel7-ha-2015r1-tgt' do
    description 'Enterprise HA addon'
    baseurl 'http://10.63.216.186:8000/rhel7-ha-2015r1-tgt/'
    gpgcheck false
    action :create
  end

  yum_repository 'rhel7-ost6-2015r1-tgt' do
    description 'Enterprise OpenStack (juno)'
    baseurl 'http://10.63.216.186:8000/rhel7-ost6-2015r1-tgt/'
    gpgcheck false
    action :create
  end

  include_recipe 'yum-epel'
end

# Install Rally prerequisite packages
%w(gcc libffi-devel python-devel openssl-devel gmp-devel libxml2-devel libxslt-devel postgresql-devel git wget python-pip).each do |pkg|
  yum_package pkg do
    action :install
  end
end

execute 'Install rally from git' do
  command 'wget -q -O- https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh | bash'
  creates '/usr/bin/rally'
  action :run
end


# Compute the hashed password in shadow format
##FIXME -- this should be a helper-lib method
#alg  = '$6$'
#salt = 'EenedOKN' ##FIXME - generate random salt
#hash = node['pcs']['hacluster_pass'].crypt(alg + salt)

# Set password for hacluster user
#user 'hacluster' do
#  password hash
#  action :modify
#end

# Start service that syncronizes the cluster configs
#service "pcsd" do
#  supports :restart => true, :reload => true, :status => true
#  action [:enable, :start]
#end

# Enable corosync and pacemaker services
#services = ['corosync', 'pacemaker']
#services.each do |service_name|
#  service service_name do
#    action :enable
#  end
#end
