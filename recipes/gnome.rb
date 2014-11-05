extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()


directory "#{user_dir}/.local/share/applications" do
  recursive true
  owner     username
end

template "#{user_dir}/.local/share/applications/mimeapps.list" do
  source "gnome/local/share/applications/mimeapps.list"
  owner   username
  variables(
    :browser => node[:nat][:browser][:default]
  )
end
