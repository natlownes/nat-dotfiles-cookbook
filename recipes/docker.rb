include_recipe 'nat::python'

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'apt-transport-https'
package 'ca-certificates'
package 'curl'

execute 'docker grab kernel extra' do
  command 'apt-get install linux-image-extra-`uname -r`'
end

execute 'docker import key' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
end

execute 'docker add repository' do
  command %{
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
  }
end

execute 'apt-get update' do
  command 'apt-get update --fix-missing'
end

package 'docker-ce' do
  version '1.12'
end

bash 'install-docker-compose' do
  code 'pip install docker-compose'
end

execute "docker add user #{username} to group" do
  command "usermod -a -G docker #{username}"
end
