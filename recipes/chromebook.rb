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
#
# "search"+F1 = XF86Back
# "search"+F2 = XF86Forward
# "search"+F3 = XF86Reload
# "search"+F4 = XF86Display
# "search"+F5 = XF86ApplicationRight
# "search"+F6 = XF86MonBrightnessDown
# "search"+F7 = XF86MonBrightnessUp
# "search"+F8 = XF86AudioMute
# "search"+F9 = XF86AudioLowerVolume
# "search"+F10 = XF86AudioRaiseVolume
# "search"+1,2,3,4,5,6,7,8,9,0 = F1,F2,F3,F4,F5,F6,F7,F8,F9,F10 ( this is additional F keys, native F keys working as usual)
# "search"+minus = F11
# "search"+equal = F12
# "search"+backspace = Del
# "search"+period = Ins (second key from the right shift)
# "search"+left = Home
# "search"+right = End
# "search"+up = PgUP
# "search"+down = PgDown
# "search"+Alt = Capslock
