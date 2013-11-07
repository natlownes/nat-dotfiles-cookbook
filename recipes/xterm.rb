extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

if node.platform_family == 'debian'
  fonts = node[:nat][:xterm][:font_packages] || []

  fonts.each do |package_name|
    package package_name
  end
end

template "#{home_dir}/.Xdefaults" do
  owner username
  source "xterm/Xdefaults"
end

link "#{home_dir}/.Xresources" do
  owner username
  to "#{home_dir}/.Xdefaults"
end
