extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
ssh_dir  = "#{home_dir()}/.ssh"

identities_dir = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => "#{home_dir()}/opt/local/mnt/keys.tc/.ssh/identities"
  },
  'mac_os_x' => {
    'default' => "/Volumes/keys/.ssh/identities"
  }
})

package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'ssh'
  },
  'mac_os_x' => {
    'default' => 'openssh'
  }
})

ssh_attributes = node[:nat][:ssh]

package package_name
package 'keychain'
package 'autossh'

directories = [
  ssh_dir,
  "#{ssh_dir}/scripts"
]

directories.each do |dir|
  directory dir do
    recursive true
    owner username
  end
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

link "#{ssh_dir}/identities" do
  to identities_dir
  owner username
end

link "#{ssh_dir}/id_dsa" do
  to "#{ssh_dir}/identities/id_dsa"
  owner username
  only_if {
    !File.exists?("#{ssh_dir}/id_dsa")
  }
end

# autossh
#
template "#{home_dir}/.ssh/scripts/autossh_start" do
  mode '0771'
  source 'ssh/autossh_start.erb'
  variables(
    :private_key_path => ssh_attributes[:auto_ssh_key_path],
    :port_map => ssh_attributes[:port_map],
    :host => ssh_attributes[:server_hostname]
  )

  only_if {
    ssh_attributes[:client_hostnames].include?(node.hostname)
  }
end
