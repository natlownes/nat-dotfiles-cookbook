extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'curl'

execute 'install-nvm' do
  environment({
    'NVM_DIR' => "#{home_dir}/.nvm"
  })
  command 'curl https://raw.githubusercontent.com/creationix/nvm/v0.17.3/install.sh | bash'
  user    username
end
