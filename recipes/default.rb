#
# Cookbook Name:: nat
# Recipe:: default
#
# Copyright 2013, Nat Lownes

extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()
src_dir  = ::File.join(user_dir, 'src')

package_manager_update_command = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'apt-get update --fix-missing'
  },
  'mac_os_x' => {
    'default' => 'port -d selfupdate'
  }
})

execute "ready-package-manager" do
  command package_manager_update_command
  action :nothing
end.run_action(:run)

include_recipe 'nat::zsh'

user username do
  home   user_dir
  shell  "/bin/zsh"
  action :create
end

directory src_dir do
  owner     username
end

packages = node[:nat][:packages] || []
os_packages = node[:nat][node.os][:packages] || []

gem_packages = node[:nat][:gem_packages] || []

packages = packages + os_packages

packages.each do |pkg_name|
  package pkg_name do
    action :install
  end
end

if node.os == 'linux'
  gem_packages.each do |gem|
    gem_package gem[:name] do
      action :install
      version gem[:version]
    end
  end
end

include_recipe 'nat::ssh'
include_recipe 'nat::tmux'
include_recipe 'nat::vim'
include_recipe 'nat::ctags'
include_recipe 'nat::git'
include_recipe 'nat::shell'
include_recipe 'nat::scripts'
include_recipe 'nat::python'
include_recipe 'nat::ruby'
include_recipe 'nat::go_lang'
include_recipe 'nat::tools'
include_recipe 'nat::nodejs'
include_recipe 'nat::aws_tools'
include_recipe 'nat::weechat'
include_recipe 'nat::various'
include_recipe 'nat::the_silver_searcher'
include_recipe 'nat::jq'
