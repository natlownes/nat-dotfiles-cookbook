extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

include_recipe "nat::docker"


package 'virtualbox'
package 'redir'
package 'cgroup-lite'

remote_file "#{Chef::Config[:file_cache_path]}/vagrant.deb" do
  source "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_x86_64.deb"
  use_etag true

  notifies :run, "execute[install-vagrant]", :immediately
end

execute "install-vagrant" do
  command "dpkg -i  #{Chef::Config[:file_cache_path]}/vagrant.deb"

  action :nothing
end

script "vagrant-install-lxc-provider" do
  user username
  environment({
    'HOME' => home_dir
  })
  interpreter "/bin/bash -i"
  code %{
    `vagrant plugin list | grep -q vagrant-lxc` || vagrant plugin install --plugin-version 0.8.0 vagrant-lxc
  }
end
