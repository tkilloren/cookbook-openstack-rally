require 'spec_helper'

describe 'openstack-rally::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(:platform => 'redhat', :version => '7') do |_node, server|
      server.create_data_bag('pacemaker', 'git' => { 'private_key' => 'test' })
    end.converge(described_recipe)
  end

#  before do
#    # apache2 stubbing
#    stub_command('[ -x /etc/init.d/httpd ] && /etc/init.d/httpd status | grep "is stopped"').and_return(false)
#    stub_command('/usr/sbin/httpd -t').and_return(true)
#  end

  it 'installs rally packages' do
    expect(chef_run).to sync_git('/opt/connector/plugins/f5-form').with(:repository => 'git@git.target.com:it-operations/f5-form.git')
  end
end
