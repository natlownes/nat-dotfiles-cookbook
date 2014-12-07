include_recipe 'nat::scripts'

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

bin_dir         = ::File.join(home_dir, '.bin')
weather_dir     = ::File.join(home_dir, '.weather')
zip_code_record = ::File.join(weather_dir, 'current_zip')

package 'curl'
package 'weather-util'

directory weather_dir do
  recursive true
  owner     username
end

template ::File.join(weather_dir, 'weatherrc') do
  source 'weather/weatherrc.erb'
end

template ::File.join(weather_dir, 'current.bash') do
  source 'weather/current.bash.erb'
  variables(
    :weather_dir     => weather_dir,
    :zip_code_record => zip_code_record
  )
end

script 'store current zip code' do
  interpreter 'bash'
  code %{
    #{bin_dir}/zipcode_current.bash > #{zip_code_record}
  }
end

cron "update zipcode store for weather" do
  hour "*"
  minute '5'
  user username
  home home_dir
  command %{bash #{bin_dir}/zipcode_current.bash > #{zip_code_record} }
end
