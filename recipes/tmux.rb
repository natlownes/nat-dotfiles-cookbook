extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
tmux_dir = "#{home_dir()}/.tmux"

source_url    = node[:nat][:tmux][:source_url]
force_install = node[:nat][:tmux][:force_install]
current_version_dirname = source_url.split('/').
  last.gsub('.tar.gz', '')

dependencies = node[:nat][:tmux][:build_dependencies] || []

dependencies.each do |pkg_name|
  package pkg_name
end

if force_install
  directory "#{home_dir}/src/tmux-source.tar.bz" do
    recursive true
    action    :delete
  end
end

remote_file "#{home_dir}/src/tmux-source.tar.bz" do
  source source_url
  owner username
  notifies :run, "execute[extract-tmux]", :immediately
end

execute "extract-tmux" do
  user username
  cwd "#{home_dir}/src"

  command "tar -xvzf tmux-source.tar.bz"

  action :nothing
  notifies :run, "execute[build-tmux]", :immediately
end

execute "build-tmux" do
  cwd "#{home_dir}/src/#{current_version_dirname}"
  user username

  command "make clean && ./configure && make"

  action :nothing
  notifies :run, "execute[install-tmux]", :immediately
end

execute "install-tmux" do
  cwd "#{home_dir}/src/#{current_version_dirname}"

  action :nothing
  command "make install"
end


directory tmux_dir do
  recursive true
  owner username
end

template "#{home_dir()}/.tmux.conf" do
  source "tmux/tmux.conf"
  owner username
end

template "#{tmux_dir}/tmux_clipboard.sh" do
  source "tmux/tmux_clipboard.sh"
  owner username
end

template "#{tmux_dir}/tmux_default_command.sh" do
  source "tmux/tmux_default_command.sh"
  owner username
  mode "0744"
end
