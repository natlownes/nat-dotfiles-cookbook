extend Nat::UserHelpers

username = user_name()
home_dir = home_dir()

tmpdir = ::Dir.mktmpdir

# kernel install, for reference
# sudo wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.17-rc1-utopic/linux-headers-3.17.0-031700rc1-generic_3.17.0-031700rc1.201408161335_amd64.deb
# sudo wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.17-rc1-utopic/linux-headers-3.17.0-031700rc1_3.17.0-031700rc1.201408161335_all.deb
# sudo wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.17-rc1-utopic/linux-image-3.17.0-031700rc1-generic_3.17.0-031700rc1.201408161335_amd64.deb
# sudo dpkg -i *.deb
# sudo reboot

nat_partial '/etc/modules' do
  source 'chromebook/modules.erb'
end

template '/etc/modprobe.d/blacklist-chromeos-laptop.conf' do
  source 'chromebook/blacklist-chromeos-laptop.conf.erb'
end

xkbscript_path = ::File.join(tmpdir, 'xkb_bindings.bash')

template xkbscript_path do
  source 'chromebook/xkb_bindings.bash'
  mode   '700'
end

bash 'apply-chromebook-keybindings' do
  code "#{xkbscript_path}"
end

# setxkbmap -model chromebook
