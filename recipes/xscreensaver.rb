extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

template "#{home_dir}/.xscreensaver" do
  source "xscreensaver/config"

  owner username
end
