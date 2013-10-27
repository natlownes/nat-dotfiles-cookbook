extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

#directory "#{home_dir}/.wmii" do
  #recursive true
  #owner username
#end

#template "#{home_dir}/.wmii/wmiirc_local" do
  #source "wmii/rc"
  #owner username
#end

#git "#{home_dir}/.wmii" do
  #repository "https://github.com/natlownes/wmiirc.git"
  #user username
  #branch 'personal'
#end

template "#{home_dir}/.xinitrc" do
  source "xorg/xinitrc"
  owner username
  variables({
    :start_command => %{
    exec wmii
  }
  })
end

file "#{home_dir}/.dmrc" do
  owner username
  content %{
[Desktop]
Session=wmii
  }
end

package 'wmii' do
  action :upgrade
end

