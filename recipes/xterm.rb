extend Nat::UserHelpers
username = user_name()
home_dir = home_dir()

template "#{home_dir}/.Xdefaults" do
  owner username
  source "xterm/Xdefaults"
end

link "#{home_dir}/.Xresources" do
  owner username
  to "#{home_dir}/.Xdefaults"
end
