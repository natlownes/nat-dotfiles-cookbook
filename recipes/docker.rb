include_recipe 'nat::python'

extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

apt_url = 'https://apt.dockerproject.org/repo'

docker_key="-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
EJOQTvBR8Q==
=Yhur
-----END PGP PUBLIC KEY BLOCK-----
"

package 'apt-transport-https'
package 'ca-certificates'
package 'curl'

execute 'docker grab kernel extra' do
  command 'apt-get install linux-image-extra-`uname -r`'
end

execute 'docker import key' do
  command %{echo "#{docker_key}" | apt-key add -}
end

execute 'docker add repository' do
  command %{
  add-apt-repository \
    "deb [arch=amd64] #{apt_url} \
      ubuntu-$(lsb_release -cs) \
      main"
  }
end

execute 'apt-get update' do
  command 'apt-get update --fix-missing'
end

package 'docker-engine' do
  version '1.12.6-0~ubuntu-xenial'
end

bash 'install-docker-compose' do
  code 'pip install docker-compose'
end

execute "docker add user #{username} to group" do
  command "usermod -a -G docker #{username}"
end
