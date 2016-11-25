include_recipe 'nat::ssh_config'

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'ssh'
  },
  'mac_os_x' => {
    'default' => 'openssh'
  }
})

ssh_attributes = node[:nat][:ssh]

if node.os == 'linux'
  package package_name
end
package 'keychain'
package 'autossh'

# autossh
#
template "#{home_dir}/.ssh/scripts/autossh_start" do
  mode '0771'
  owner username
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
