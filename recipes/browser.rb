extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

browser_package_path = ::File.join(
  user_dir, (node[:browser][:package_path] || "Downloads")
)

remote_file "#{browser_package_path}/google-chrome-stable_current_amd64.deb" do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  use_etag true

  notifies :run, "execute[install-googs-chrome]", :immediately
end

execute "install-googs-chrome" do
  command "dpkg -i  #{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb"

  action :nothing
end
