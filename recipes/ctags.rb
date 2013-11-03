extend Nat::UserHelpers
username = user_name()
user_dir = home_dir()

package_name = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'exuberant-ctags'
  },
  'mac_os_x' => {
    'default' => 'ctags'
  }
})

package package_name

template "#{user_dir}/.ctags" do
  source "ctags/ctags"
  owner  username
end

