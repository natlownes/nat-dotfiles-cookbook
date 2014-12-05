extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

if platform?('ubuntu')
  # fix for https://tickets.opscode.com/browse/CHEF-3940
  apt_repository "git-core" do
    uri "http://ppa.launchpad.net/git-core/ppa/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "E1DF1F24"
  end
end

package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'git'
  },
  'mac_os_x' => {
    'default' => 'git-core'
  }
})

package package_name


template "#{home_dir}/.gitconfig" do
  source "git/gitconfig"
  owner username
end

template "#{home_dir}/.gitignore" do
  source "git/gitignore"
  owner username
end

template "#{home_dir}/.gitignore_global" do
  source "git/gitignore_global"
  owner username
end

execute "install-gitflow" do
  command "wget --no-check-certificate -q -O - https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh | bash"
end
