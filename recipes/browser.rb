remote_file "#{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb" do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  use_etag true

  notifies :run, "execute[install-googs-chrome]", :immediately
end

execute "install-googs-chrome" do
  command "dpkg -i  #{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb"

  action :nothing
end
