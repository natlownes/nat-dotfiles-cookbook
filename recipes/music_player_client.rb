include_recipe 'nat::scripts'


extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()
bin_dir  = ::File.join(home_dir, '.bin')

mpd_music_dir = ::File.join(home_dir, '.mpc', 'music')

template "#{bin_dir}/mpc_start.sh" do
  source 'music_player_client/mpc_start.sh.erb'
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

directory ::File.join(home_dir, '.ncmpcpp') do
  owner username
end

directory mpd_music_dir do
  owner username
end

template ::File.join(home_dir, '.ncmpcpp', 'config') do
  source 'music_player_client/ncmpcpp/config.erb'
  owner username

  variables(
    :mpd_music_dir => mpd_music_dir
  )
end
