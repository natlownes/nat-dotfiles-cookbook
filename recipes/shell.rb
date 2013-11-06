extend Nat::UserHelpers
username         = user_name()
shell_config_dir = "#{home_dir()}/.shell"

directory shell_config_dir do
  recursive true
  owner username

  action :create
end

template "#{shell_config_dir}/aliases" do
  source "shell/aliases"
  owner username
end

template "#{home_dir()}/.inputrc" do
  source "shell/inputrc"
  owner username
end

template "#{shell_config_dir}/paths" do
  source "shell/paths"
  owner username
end

template "#{shell_config_dir}/ssh_agent" do
  source "shell/ssh_agent"
  owner username
end

template "#{shell_config_dir}/functions" do
  source "shell/functions"
  owner username
end

template "#{shell_config_dir}/variables" do
  source "shell/variables"
  owner username
end

template "#{shell_config_dir}/envs" do
  source "shell/envs"
  owner username
end


