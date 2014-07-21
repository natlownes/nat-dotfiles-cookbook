extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


template "#{home_dir}/.xbindkeysrc.scm" do
  owner username
  source "xorg/xbindkeysrc.scm.erb"
end
