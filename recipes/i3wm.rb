include_recipe 'nat::python'

extend Nat::UserHelpers
username       = user_name()
home_dir       = home_dir()
i3_config_dir  = "#{home_dir}/.i3"
virtualenv_dir = "#{home_dir}/.i3/virtualenv"

directory i3_config_dir do
  recursive true
  owner username
end

directory "#{i3_config_dir}/scripts" do
  recursive true
  owner username
end

directory "#{i3_config_dir}/workspaces" do
  recursive true
  owner username
end

execute "install-py3status-virtualenv" do
  command "virtualenv #{virtualenv_dir}/py3status"
  user    username
end

git "#{i3_config_dir}/py3status_modules" do
  repository 'https://github.com/natlownes/py3status_modules.git'
  user       username
  branch     'master'

  action :sync
end

execute "install py3status_modules dependencies" do
  command "#{virtualenv_dir}/py3status/bin/pip install -r #{i3_config_dir}/py3status_modules/requirements.txt"
  user username
end

link "#{i3_config_dir}/py3status" do
  to "#{i3_config_dir}/py3status_modules/py3status_modules"
  owner username
end

template "#{i3_config_dir}/config" do
  source "i3/config.erb"
  owner username
  variables(
    #:i3status_command => "bash #{i3_config_dir}/scripts/i3status.bash",
    :i3status_command => "py3status",
    :browser          => node[:nat][:browser][:default],
    :home_directory   => home_dir,
    :terminal         => 'urxvt',
    :xrandr_displays  => node.xrandr_outputs,
    :node             => node,
    :start_dropbox    => !node.is_chromebook?
  )
end

template "#{i3_config_dir}/scripts/exit_dialog.sh" do
  source "i3/exit_dialog.sh"
  owner username
  mode '755'
end

template "#{i3_config_dir}/scripts/i3status.bash" do
  source "i3/i3status.bash"
  owner username
  mode '755'
  variables(
    :home_dir => home_dir
  )
end

template "#{i3_config_dir}/scripts/workspaces.sh" do
  source "i3/workspaces.sh.erb"
  owner username
  mode '755'
end

template "#{home_dir}/.i3status.conf" do
  source "i3/i3status.conf.erb"
  owner username
end

execute "apt-get-update" do
  command "apt-get update --fix-missing"

  action :nothing
end

if node.platform == 'ubuntu'
  package 'ubuntu-desktop'
  package 'xscreensaver'

  # this fucking thing intercepts control spacebar globally
  package 'ibus-setup' do
    action :remove
    only_if "which ibus-setup"
  end

  file "/etc/apt/sources.list.d/i3wm.list" do
    content "deb http://debian.sur5r.net/i3/ #{node['lsb']['codename']} universe"

    notifies :run, "execute[apt-get-update]", :immediately
  end

  execute "install-i3wm-keyring" do
    command "apt-get --allow-unauthenticated install sur5r-keyring"

    notifies :run, "execute[apt-get-update]", :immediately
  end

  package 'i3'

  template "#{home_dir}/.xinitrc" do
    source "xorg/xinitrc"
    owner username
    variables({
      :start_command => %{
      exec i3
    }
    })
  end

  file "#{home_dir}/.dmrc" do
    owner username
    content %{
[Desktop]
Session=i3
    }
  end

end
