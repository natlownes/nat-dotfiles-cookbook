extend Nat::UserHelpers
username = user_name()
ssh_dir  = "#{home_dir()}/.ssh"

package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'ssh'
  },
  'mac_os_x' => {
    'default' => 'openssh'
  }
})

package package_name

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

