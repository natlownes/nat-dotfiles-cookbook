extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

src_dir = "#{home_dir}/src"
bin_dir = "#{home_dir}/.bin"

directory src_dir do
  recursive true
  owner username
end

directory bin_dir do
  recursive true
  owner username
end

inotify_package = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'inotify-tools'
  },
  'mac_os_x' => {
    'default' => nil
  }
})

package inotify_package if inotify_package

git "#{src_dir}/continually" do
  repository 'https://github.com/markchadwick/continually.git'
  reference 'master'
  user username

  action :sync
end

execute "ensure-continually-is-executable" do
  command "chmod 744 #{src_dir}/continually/continually"
  user username
end

link "#{bin_dir}/continually" do
  to "#{src_dir}/continually/continually"
end


apt_repository "peru" do
  uri 'http://ppa.launchpad.net/buildinspace/peru/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key '8C3DE616'
end

package 'peru'
