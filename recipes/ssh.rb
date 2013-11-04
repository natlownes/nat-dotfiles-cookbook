extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
ssh_dir  = "#{home_dir()}/.ssh"

identities_dir = "#{home_dir()}/opt/local/mnt/keys.tc/.ssh/identities"

package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'ssh'
  },
  'mac_os_x' => {
    'default' => 'openssh'
  }
})

package package_name
package 'keychain'

directory ssh_dir do
  recursive true
  owner username
end

template "#{ssh_dir}/authorized_keys" do
  owner username
  source "ssh/authorized_keys"
  mode "0600"
end

template "#{ssh_dir}/config" do
  owner username
  source "ssh/config"
end

template "#{ssh_dir}/rc" do
  owner username
  source "ssh/rc"
end

link "#{home_dir}/.ssh/identities" do
  to identities_dir
  owner username
end

link "#{home_dir}/.ssh/id_dsa" do
  to "#{home_dir}/.ssh/identities/id_dsa"
  owner username
  only_if {
    !File.exists?("#{home_dir}/.ssh/id_dsa")
  }
end
