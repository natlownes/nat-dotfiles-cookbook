extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
tmux_dir = "#{home_dir()}/.tmux"

source_url    = node[:nat][:tmux][:source_url]
force_install = node[:nat][:tmux][:force_install]
current_version_dirname = 'tmux-1.9a'

dependencies = node[:nat][:tmux][node.os][:build_dependencies] || []

build_command = if node.os == 'darwin'
                  %(LDFLAGS="-L/opt/local/lib" \
                   CPPFLAGS="-I/opt/local/include" \
                   LIBS="-lresolv" \
                   sh autogen.sh && ./configure && make)
                else
                  %(sh autogen.sh && ./configure && make)
                end

dependencies.each do |pkg_name|
  package pkg_name
end

if force_install
  bash "force-install-tmux" do
    code "rm -rf #{home_dir}/src/tmux*"
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

  command build_command

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
