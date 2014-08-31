extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

rbenv_path         = "#{home_dir}/#{node[:nat][:ruby][:rbenv][:install_path]}"
rbenv_plugins_path = "#{rbenv_path}/plugins"
ruby_build_path    = "#{home_dir}/#{node[:nat][:ruby][:ruby_build][:install_path]}"

git rbenv_path do
  repository node[:nat][:ruby][:rbenv][:scm_url]
  reference 'master'
  user      username

  action :sync
end

directory  rbenv_plugins_path do
  owner username
  recursive true
end

git ruby_build_path do
  repository node[:nat][:ruby][:ruby_build][:scm_url]
  reference  'master'
  user       username

  action :sync
end
