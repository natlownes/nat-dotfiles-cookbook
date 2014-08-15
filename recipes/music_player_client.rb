include_recipe 'nat::scripts'


extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
bin_dir  = ::File.join(home_dir, '.bin')

template "#{bin_dir}/mpc_start.sh" do
  variables(
    :cache_size => node[:nat][:music_player_client][:cache_size],
    :gateway    => node[:nat][:music_player_client][:gateway],
    :local      => node[:nat][:music_player_client][:local],
    :server     => node[:nat][:music_player_client][:server],
  )

  owner  username
  mode   "770"
  action :create
end
