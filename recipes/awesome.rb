extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

directory "#{home_dir}/.config" do
  recursive true
  owner username
end

git "#{home_dir}/.config/awesome" do
  repository "https://github.com/tony/awesome-config"
  user username
end

execute "update awesome submodules" do
  command "cd #{home_dir}/.config/awesome && git submodule init && git submodule update"
  user username
end

package 'awesome'
package 'xfonts-terminus'

template "#{home_dir}/.xinitrc" do
  source "xorg/xinitrc"
  owner username
  variables({
    :start_command => %{
    exec awesome
  }
  })
end

template "#{home_dir}/.config/awesome/personal.lua" do
  source "awesome/personal.lua"
  owner username
end

template "/usr/share/xsessions/awesome.desktop" do
  mode "0644"
  source "awesome/awesome.desktop"
end

file "#{home_dir}/.dmrc" do
  owner username
  content %{
[Desktop]
Session=awesome
  }
end
