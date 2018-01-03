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

remote_file "#{bin_dir}/git-icdiff" do
  source 'https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff'
  owner username
  mode "755"
  if self.respond_to?(:use_conditional_get)
    use_conditional_get true
  end
end

remote_file "#{bin_dir}/icdiff" do
  source 'https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff'
  owner username
  mode "755"
  if self.respond_to?(:use_conditional_get)
    use_conditional_get true
  end
end

cookbook_file "#{bin_dir}/buildozer" do
  source 'buildozer'
  mode '0744'
  owner username
end

cookbook_file "#{bin_dir}/buildifier" do
  source 'buildifier'
  mode '0744'
  owner username
end
