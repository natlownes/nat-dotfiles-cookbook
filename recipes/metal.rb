#
# recipes for bare metal machine
#
extend Nat::MachineHelpers


include_recipe 'nat::default'


execute 'apt-get update' do
  command "apt-get update --fix-missing"
  action :nothing
end.run_action(:run)

packages = node[:nat][:metal][:packages] || []
gem_packages = node[:nat][:metal][:gem_packages] || []

packages.each do |pkg_name|
  package pkg_name do
    action :install
  end
end

gem_packages.each do |gem|
  gem_package gem[:name] do
    action :install
    version gem[:version]
  end
end

include_recipe 'nat::dropbox'
include_recipe 'nat::fs_crypt_tools'
include_recipe 'nat::gnome'
include_recipe 'nat::i3wm'
include_recipe 'nat::pwsafe'
include_recipe 'nat::spotify'
include_recipe 'nat::weechat'
include_recipe 'nat::xscreensaver'
include_recipe 'nat::xterm'
include_recipe 'nat::music_player_client'
include_recipe 'nat::browser'

if is_desktop?
  include_recipe 'nat::docker'
  include_recipe 'nat::virtualization'
  include_recipe 'nat::qgis'
  include_recipe 'nat::wine'
end

if is_chromebook?
  include_recipe 'nat::chromebook'
end
