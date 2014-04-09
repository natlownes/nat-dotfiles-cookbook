extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'curl'

execute 'install-nvm' do
  environment({
    'NVM_DIR' => "#{home_dir}/.nvm"
  })
  command 'curl https://raw.github.com/creationix/nvm/master/install.sh | sh'
  user    username
end
