extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

package 'gnupg2'

directory "#{home_dir}/.gnupg" do
  owner username
  recursive true
  action :create
end

template "#{home_dir}/.gnupg/gpg.config" do
  source "pgp/gpg.conf.erb"
  owner username
end
