extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'curl'

nvm_dir = "#{home_dir}/.nvm"

execute 'install-nvm' do
  environment({
    'NVM_DIR' => nvm_dir
  })
  not_if { ::File.directory?(nvm_dir) }
  command 'curl https://raw.github.com/creationix/nvm/master/install.sh | sh'
  user    username
end
