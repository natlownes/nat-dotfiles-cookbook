extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

directory "#{user_dir}/.bin" do
  recursive true
  owner username

  action :create
end

cookbook_file "#{home_dir}/.bin/mount.tc" do
  source "scripts/mount.tc"
  owner username
  mod "0744"
end


