include_recipe 'nat::python'

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()


execute 'docker grab kernel extra' do
  command 'apt-get install linux-image-extra-`uname -r`'
end

execute 'docker import key' do
  command 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9'
end

file '/etc/apt/sources.list.d/docker.list' do
  content %{deb http://get.docker.io/ubuntu docker main}

  action :create
end

execute 'apt-get update' do
  command 'apt-get update'
end

package 'lxc-docker'

bash 'install-docker-compose' do
  code 'pip install docker-compose'
end

execute "docker add user #{username} to group" do
  command "usermod -a -G docker #{username}"
end
