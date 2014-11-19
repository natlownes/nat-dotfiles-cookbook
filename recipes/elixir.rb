extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

destination = "#{Chef::Config[:file_cache_path]}/erlang-solutions_1.0_all.deb"

remote_file destination do
  source "http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb"

  action :nothing
  notifies :run, 'execute[add-erlang-repo]', :immediately
end

execute 'add-erlang-repo' do
  environment({
    'DEBIAN_FRONTEND' => 'noninteractive'
  })
  command "dpkg -i #{destination}"
  action :nothing

  notifies :run, 'execute[apt-get-update]', :immediately
end

execute 'apt-get-update' do
  command 'apt-get update --fix-missing'
  action :nothing
end
