extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

package 'exuberant-ctags'

template "#{user_dir}/.ctags" do
  source "ctags/ctags"
  owner  username
end

