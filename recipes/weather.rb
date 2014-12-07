extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'weather-util'

template "#{home_dir}/.weatherrc" do
  source "weather/weatherrc.erb"
end
