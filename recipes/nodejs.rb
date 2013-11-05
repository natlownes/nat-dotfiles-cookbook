extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'curl'

execute 'install-nvm' do
  command 'curl https://raw.github.com/creationix/nvm/master/install.sh | sh'
  user    username
end
