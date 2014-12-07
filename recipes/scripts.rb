extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

directory "#{user_dir}/.bin" do
  recursive true
  owner username

  action :create
end

script_files = %w(
key_mount.bash
mount.tc
nvm_env.sh
source_bash.zsh
ssh_agent_copy_env.bash
ssh_agent_reset.bash
zipcode_current.bash
)

vistar_script_files = %w(
vistar_clone_project.bash
vistar_provision_vm.bash
vistar_release_summary.bash
vistar_vagrant_command.bash
)

use_scripts = script_files + vistar_script_files

use_scripts.each do |filename|
  cookbook_file "#{home_dir}/.bin/#{filename}" do
    source "scripts/#{filename}"
    owner username
    mode "0744"
  end
end
