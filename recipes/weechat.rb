extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

directory "#{home_dir}/src" do
  recursive true
  owner username
end

if node.platform_family == 'debian'
  weechat_source_url      = node[:nat][:weechat][:src_url]
  current_version_dirname = weechat_source_url.split('/').
    last.gsub('.tar.bz2', '')

  dependencies = node[:nat][:weechat][:build_dependencies] || []

  dependencies.each do |pkg_name|
    package pkg_name
  end

  remote_file "#{home_dir}/src/weechat-source.tar.bz" do
    source weechat_source_url
    owner username
    notifies :run, "execute[extract-weechat]", :immediately
  end

  execute "extract-weechat" do
    user username
    cwd "#{home_dir}/src"

    command "tar -xvjf weechat-source.tar.bz"

    action :nothing
    notifies :run, "execute[build-weechat]", :immediately
  end

  execute "build-weechat" do
    cwd "#{home_dir}/src/#{current_version_dirname}"
    user username

    command "mkdir -p build && cd build && cmake .. && make"

    action :nothing
    notifies :run, "execute[install-weechat]", :immediately
  end

  execute "install-weechat" do
    cwd "#{home_dir}/src/#{current_version_dirname}/build"

    action :nothing
    command "make install"
  end

end
