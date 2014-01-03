package_manager_update_command = value_for_platform({
  ['debian', 'ubuntu'] => {
    'default' => 'apt-get update --fix-missing'
  },
  'mac_os_x' => {
    'default' => 'port -d selfupdate'
  }
})

execute "ready-package-manager" do
  command package_manager_update_command
  action :nothing
end.run_action(:run)



