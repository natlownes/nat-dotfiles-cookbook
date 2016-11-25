extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
ssh_dir  = "#{home_dir()}/.ssh"

ssh_attributes = node[:nat][:ssh]

#identities_dir = value_for_platform({
  #['debian', 'ubuntu'] => {
    #'default' => "#{home_dir()}/opt/local/mnt/home/home/.ssh/identities"
  #},
  #'mac_os_x' => {
    #'default' => "/Volumes/keys/.ssh/identities"
  #}
#})


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
  variables(
    'tunnels' => ssh_attributes[:tunnels]
  )
end

template "#{ssh_dir}/rc" do
  owner username
  source "ssh/rc"
end

#link "#{ssh_dir}/identities" do
  #to identities_dir
  #owner username
#end

link "#{ssh_dir}/id_dsa" do
  to "#{ssh_dir}/identities/id_dsa"
  owner username
  only_if {
    !File.exists?("#{ssh_dir}/id_dsa")
  }
end

