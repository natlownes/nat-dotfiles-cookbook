extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

include_recipe 'nat::source_directory'

#nat_source_install 'jq' do
  #version '1.4'
  #source 'http://stedolan.github.io/jq/download/source/'
#end
