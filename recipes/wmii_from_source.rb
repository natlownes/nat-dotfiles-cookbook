extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

directory "#{home_dir}/src" do
  recursive true
  owner username
end

if node[:nat][:wmii][:force_install]
  file "#{home_dir}/src/wmii.tbz" do
    action :delete
  end

  package 'wmii' do
    action :remove
  end
end

(node[:nat][:wmii][:build_dependencies] || []).each do |pkg|
  package pkg[:name] do
    version pkg[:version]
    action :install
  end
end

cookbook_file "#{home_dir}/src/wmii+ixp-3.9b1/config.mk" do
  owner username
  source "wmii/config.mk"
  action :nothing

  notifies :run, "execute[build-wmii-from-source]", :immediately
end

execute "build-wmii-from-source" do
  cwd "#{home_dir}/src/wmii+ixp-3.9b1"
  command "make && make install"
  action :nothing
end

execute "extract-wmii" do
  cwd "#{home_dir}/src"
  command "tar -xjvf #{home_dir}/src/wmii.tbz"
  user username
  action :nothing

  notifies :create, "cookbook_file[#{home_dir}/src/wmii+ixp-3.9b1/config.mk]", :immediately
end

remote_file "#{home_dir}/src/wmii.tbz" do
  source node[:nat][:wmii][:source_url]
  owner username

  notifies :run, "execute[extract-wmii]", :immediately
end

remote_directory "#{home_dir}/.wmii" do
  source "wmii/ruby"
  owner username
end

template "#{home_dir}/.xinitrc" do
  source "xorg/xinitrc"
  owner username
  variables({
    :start_command => %{
    exec wmii
  }
  })
end

file "#{home_dir}/.dmrc" do
  owner username
  content %{
[Desktop]
Session=wmii
  }
end

template "/usr/share/xsessions/wmii.desktop" do
  source "wmii/xsessions"
  mode "0644"
end

