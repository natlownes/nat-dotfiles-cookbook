#
# Cookbook Name:: nat
# Recipe:: default
#
# Copyright 2013, Nat Lownes

extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

include_recipe 'nat::preflight'
include_recipe 'nat::user'
include_recipe 'nat::zsh'

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
include_recipe 'nat::tools'
include_recipe 'nat::nodejs'
include_recipe 'nat::aws_tools'
include_recipe 'nat::weechat'
include_recipe 'nat::various'

