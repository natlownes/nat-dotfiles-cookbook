extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

browser_package_path = ::File.join(
  user_dir, (node[:nat][:browser][:package_path] || "Downloads")
)

directory browser_package_path do
  owner     username
  recursive true
  action    :create
end

remote_file "#{browser_package_path}/google-chrome-stable_current_amd64.deb" do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  use_etag true
  owner username

  notifies :run, "execute[install-googs-chrome]", :immediately
end

execute "install-googs-chrome" do
  command "dpkg -i  #{browser_package_path}/google-chrome-stable_current_amd64.deb"

  action :nothing
end

remote_file "#{browser_package_path}/firefox.tar.bz2" do
  source "https://download.mozilla.org/?product=firefox-33.1.1-SSL&os=linux64&lang=en-US"
  use_etag true
  owner username

  notifies :run, 'execute[install-firefox]', :immediately
end

execute 'install-firefox' do
  command "tar -C #{user_dir} -xjvf #{browser_package_path}/firefox.tar.bz2"
  user username

  action :nothing
  notifies :create, 'link[firefox]', :immediately
end

link 'firefox' do
  owner username
  target_file "#{user_dir}/.bin/firefox"
  to          "#{user_dir}/firefox/firefox"

  action :nothing
end
