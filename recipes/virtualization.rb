extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

include_recipe "nat::docker"


package 'wget'
package 'virtualbox'
package 'redir'
package 'cgroup-lite'


remote_file "#{Chef::Config[:file_cache_path]}/vagrant.deb" do
  source "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb"
  use_etag true
end

bash 'install-vagrant' do
  code %{
    dpkg -i  #{Chef::Config[:file_cache_path]}/vagrant.deb
  }
  not_if 'which vagrant'
end

script "vagrant-install-lxc-provider" do
  user username
  environment({
    'HOME' => home_dir
  })
  interpreter "/bin/bash"
  code %{
    `vagrant plugin list | grep -q vagrant-lxc` || vagrant plugin install --plugin-version 0.8.0 vagrant-lxc
  }
end
