#
# recipes for bare metal machine
#

include_recipe 'nat::default'

execute 'apt-get update' do
  command "apt-get update --fix-missing"
  action :nothing
end.run_action(:run)

packages = node[:nat][:metal][:packages] || []

packages.each do |pkg_name|
  package pkg_name do
    action :install
  end
end

include_recipe 'nat::xterm'
include_recipe 'nat::dropbox'
include_recipe 'nat::pwsafe'
include_recipe 'nat::weechat'
include_recipe 'nat::wmii_from_source'

