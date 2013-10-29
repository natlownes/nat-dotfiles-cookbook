extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

directory "#{home_dir}/.config/xscreensaver" do
  recursive true
  owner username
end

template "#{home_dir}/.xscreensaver" do
  source "xscreensaver/config"

  owner username
end

template "#{home_dir}/.config/xscreensaver/rc" do
  source "xscreensaver/rc"

  owner username
end
