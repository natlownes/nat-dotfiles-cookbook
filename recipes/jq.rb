extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

include_recipe 'nat::source_directory'

remote_file "#{home_dir}/src/weechat-source.tar.bz" do
  source weechat_source_url
  owner username
  notifies :run, "execute[extract-weechat]", :immediately
end


