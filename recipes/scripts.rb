extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

directory "#{user_dir}/.bin" do
  recursive true
  owner username

  action :create
end

script_files = %w(
mount.tc
key_mount.bash
)

vistar_script_files = %w(
vistar_provision_vm.bash
vistar_ssh_vagrant.bash
vistar_clone_project.bash
)

use_scripts = script_files + vistar_script_files

use_scripts.each do |filename|
  cookbook_file "#{home_dir}/.bin/#{filename}" do
    source "scripts/#{filename}"
    owner username
    mode "0744"
  end
end
