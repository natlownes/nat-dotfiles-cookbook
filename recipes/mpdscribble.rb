# install and configure mpdscribble, a last.fm client for mpd
#
#

extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

mpdscribble_dir = ::File.join(user_dir, '.mpdscribble')
mpd_host        = node[:nat][:mpdscribble][:mpd][:host] || 'localhost'
mpd_port        = node[:nat][:mpdscribble][:mpd][:port] || '6600'

package 'mpdscribble'


directory mpdscribble_dir do
  owner username
end

template ::File.join(mpdscribble_dir, 'mpdscribble.conf') do
  source 'mpdscribble/mpdscribble.conf.erb'
  owner  username
  variables(
    :mpdscribble_dir => mpdscribble_dir,
    :username => node[:nat][:mpdscribble][:username],
    :password => node[:nat][:mpdscribble][:password],
    :mpd_host => mpd_host,
    :mpd_port => mpd_port
  )
end
