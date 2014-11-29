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

execute "vagrant-install-lxc-provider" do
  command "su #{username} -c 'vagrant plugin install vagrant-lxc'"
  user username
  not_if %{su #{username} -c 'vagrant plugin list |grep -q vagrant-lxc'}
end
