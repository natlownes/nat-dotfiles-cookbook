include_recipe 'nat::aws_tools'
include_recipe 'nat::source_directory'


extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

weechat_dir = "#{home_dir}/.weechat"


#
### install ###
#

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

if node.platform_family == 'darwin'
  package 'weechat'
end


#
### setup ###
#

directory weechat_dir do
  owner username
  recursive true
end

directories = %w(
  python
  ruby
  logs
  sslcerts
  xfer
)

directories.each do |dir_name|
  directory "#{weechat_dir}/#{dir_name}" do
    owner username
    recursive true
  end
end


plugins = node[:nat][:weechat][:plugins] || []

plugins.each do |plugin|
  path = "#{home_dir}/#{plugin['path']}"
  url  = plugin['url']

  filename      = path.split('/').last
  plugin_dir    = File.join(path.split('/')[0..-2])
  autoload_dir  = File.join(plugin_dir, 'autoload')
  autoload_path = File.join(autoload_dir, filename)

  directory autoload_dir do
    owner username
    recursive true
  end

  remote_file path do
    source url
    owner username

    if self.respond_to?(:use_conditional_get)
      use_conditional_get true
    end

    if self.respond_to(:use_etag)
      use_etag true
    end

    action :create
  end

  # autoload everything
  link autoload_path do
    to path
    owner username
  end
end

templates = %w(
  alias.conf
  aspell.conf
  sec.conf
  charset.conf
  irc.conf
  logger.conf
  plugins.conf
  relay.conf
  script.conf
  weechat.conf
  xfer.conf
)

templates.each do |template|
  template "#{weechat_dir}/#{template}" do
    owner username
    source "weechat/#{template}.erb"
    variables(
      :weechat => node[:nat][:weechat]
    )
  end
end
