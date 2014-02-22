remote_file "#{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb" do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
end

execute "install googs chrome" do
  command "dpkg -i  #{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb"
end
