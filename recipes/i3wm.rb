extend Nat::UserHelpers
username      = user_name()
home_dir      = home_dir()
i3_config_dir = "#{home_dir}/.i3"

directory i3_config_dir do
  recursive true
  owner username
end

template "#{i3_config_dir}/config" do
  source "i3/config"
  owner username
end

execute "apt-get-update" do
  command "apt-get update --fix-missing"

  action :nothing
end

if node.platform == 'ubuntu'
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

